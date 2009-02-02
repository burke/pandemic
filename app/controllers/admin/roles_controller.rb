class Admin::RolesController < AdminController
  def index
    @roles = Role.find(:all)
  end

  def show
    @role = Role.find(params[:id])
  end

  def new
    @role = Role.new
  end

  def edit
     
    @role = Role.find(params[:id])
  end

  def create
     
    @role = Role.new(params[:role])

    if @role.save
      flash[:success] = 'Role was successfully created.'
      redirect_to [:admin,@role]
    else
      render :action => "new" 
    end
  end

  def update
     
    @role = Role.find(params[:id])

    if @role.update_attributes(params[:role])
      flash[:success] = 'Role was successfully updated.'
      redirect_to [:admin,@role] 
    else
      render :action => "edit" 
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @role.destroy
    flash[:success] = "Role has been removed"    
    redirect_to(admin_roles_url)
  end
end
