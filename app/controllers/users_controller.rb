class UsersController < ApplicationController

  before_filter :redirect_to_root, :only => [:new, :create], :if => :logged_in?
  filter_parameter_logging :password
  
  def new
    @user = User.new(params[:user])
  end
  
  def confirm
    @user = User.find_by_id_and_salt(params[:user_id], params[:salt])
    if @user
      flash[:success] = 'Successfully confirmed.'
      @user.confirm!
      redirect_to login_url
    else
      flash[:error] = 'Invalid user.'
      redirect_to register_url
    end
  end  
  
  def create
    @user = User.new params[:user]
    if @user.save
      UserMailer.deliver_confirmation @user
      flash[:success] = "You will receive an email within the next few minutes. It contains instructions for you to confirm your account."
      redirect_to login_url
    else
      render :action => "new"
    end
  end
end
