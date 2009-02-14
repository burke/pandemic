class SessionsController < ApplicationController
  
  skip_before_filter :authenticate
  protect_from_forgery :except => :create
  filter_parameter_logging :password
  
  def create
    remember_me = params[:session][:remember_me] if params[:session]
    login_via_password(params[:session][:email], params[:session][:password], remember_me)
  end
  
  def new
    render :layout => lambda{ |c| c.request.xhr? ? '/layouts/ajax' : 'application' }
  end

  def destroy
    forget(current_user)
    reset_session
    flash[:success] = 'You have been logged out.'
    redirect_to login_url
  end

  private
  
  def login_via_password(email, password, remember_me)
    user = User.authenticate(email, password)
    if user && user.confirmed? && login(user)
      create_session_for(user)
      remember(user) if remember_me == true
      login_successful
    else
      login_failure
    end
  end
  
  def login_successful
    flash[:success] = 'Logged in successfully.'
    redirect_back_or dashboard_url  
  end

  def login_failure(message = "Bad email or password.")
    flash.now[:error] = message
    render :action => :new
  end
 
  def remember(user)
    user.remember_me!
    user.save
    cookies[:auth_token] = { :value   => user.remember_token, 
                             :expires => user.remember_token_expires_at }
  end
 
  def forget(user)
    user.forget_me! if user
    cookies.delete :auth_token
  end
end
