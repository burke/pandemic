class UsersController < ApplicationController

  before_filter :redirect_to_root, :only => [:new, :create], :if => :logged_in?
  filter_parameter_logging :password
  
  def new
    @user = user_model.new(params[:user])
    render :layout => lambda{ |c| c.request.xhr? ? '/layouts/ajax' : 'application' }
  end
  
  before_filter :existing_user?
      
  def confirm
    @user = User.find_by_id_and_salt(params[:user_id], params[:salt])
    if @user
      flash[:success] = 'Successfully confirmed'
       @user.confirm!
       redirect_to login_url
    else
      flash[:error] = 'invalid user'
      redirect_to register_url
    end
  end  
  
  def create
    @user = user_model.new params[:user]
    if @user.save
      UserMailer.deliver_confirmation @user
      flash[:success] = "You will receive an email within the next few minutes. It contains instructions for you to confirm your account."
      redirect_to login_path
    else
      render :action => "new"
    end
  end
  
 private
    
  def existing_user?
    
  end
  
end