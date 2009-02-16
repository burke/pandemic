class PasswordsController < DashboardController
  skip_before_filter       :authenticate, :only => [:new,:create,:reset]
  
  filter_parameter_logging :password, 
                           :password_confirmation
  
  def new
    render :action => :new,:layout => 'application'
  end
  
  def show
    render :action => :edit
  end
  
  def create
    @user = User.find_by_email params[:password][:email]
    if @user.nil?
      flash.now[:error] = 'Unknown email'
      render :action => :new, :layout => 'application'
    else
      flash[:success] = 'Password recovery email sent.'
      UserMailer.deliver_change_password @user
      redirect_to login_url
    end
  end
  
  def edit
  end

  def reset
    @user = User.find_by_email_and_crypted_password(params[:user], params[:token])
    if @user.present?
      flash[:success] = 'Valid.' #Maybe more verbose here?
      login @user
      render :action => :edit
    else
      flash[:error] = 'Invalid.'
      render :action => :new
    end
  end
  
  def update
    if current_user.update_attributes(params[:user])
      flash[:success] = 'Password updated.'
      redirect_to dashboard_url
    else
      flash[:error] = 'Update failed.'
      render :action => :edit
    end
  end
end