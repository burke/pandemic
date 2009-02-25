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
  
  def show
    redirect_to login_url
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
      deny_access :flash => "Bad email or password." 
    end
  end
  
  def login_successful
    flash[:success] = 'Logged in successfully.'
    redirect_back_or dashboard_url
  end

  def remember(user)
    user.remember_me!
    cookies[:remember_token] = { :value   => user.remember_token, 
                                 :expires => user.remember_token_expires_at }
  end
 
  def forget(user)
    user.forget_me! if user
    cookies.delete :remember_token
  end
end
