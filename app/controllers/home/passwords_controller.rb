class Home::PasswordsController < HomeController
  skip_before_filter       :authenticate, :only => [:new,:create,:reset]
  
  filter_parameter_logging :password, 
                           :password_confirmation
  
  def new
  end
  
  def show
    render :action => :edit
  end
  
  def create
    @user = User.find_by_email params[:password][:email]
    if @user.nil?
      flash.now[:warning] = 'Unknown email'
      render :action => :new
    else
      flash[:notice] = 'Password Recovery Email sent'
      UserMailer.deliver_change_password @user
      redirect_to login_url
    end
  end
  
  def edit
  end

  def reset
    @user = User.find_by_email_and_crypted_password(params[:user], params[:token])
    if @user.present?
      flash[:notice] = 'valid'
      login @user
      render :action => :edit
    else
      flash[:error] = 'Invalid'
      render :action => :new
    end
  end
  
  def update
    if current_user.update_attributes(params[:user])
      flash[:notice] = 'Password updated'
      redirect_to home_url
    else
      flash[:error] = 'update failed'
      render :action => :edit
    end
  end
end
