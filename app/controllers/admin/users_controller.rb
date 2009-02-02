class Admin::UsersController < AdminController
  def index
    @users = User.find(:all)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @roles = Role.all
  end

  def edit
    @user = User.find(params[:id])
    @roles = Role.all
  end

  def create
    @user = User.new(params[:user])
    @roles = Role.all
    if @user.save
      flash[:success] = 'User was successfully created.'
      redirect_to([:admin,@user]) 
    else
      render :action => "new" 
    end
  end

  def update
    @user = User.find(params[:id])
    @roles = Role.all
    
    #needs to be refactored as to not allow normal users from guessing and giving themselves higher permission sets
    #
    # using attr_protected
    # @user.role_ids << params[:user][:role_ids]
    #  
    params[:user][:role_ids] ||= []
    if @user.update_attributes(params[:user])
      flash[:success] = 'User was successfully updated.'
      redirect_to([:admin,@user]) 
    else
      render :action => "edit" 
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User #{@user.email} was removed"
    redirect_to(admin_users_url)   
  end
end
