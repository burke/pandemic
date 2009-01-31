class Home::PersonalsController < HomeController
  before_filter :load_user

  def show
    render :action => :edit
  end

  def edit
    @roles = Role.all
  end

  def update
    @roles = Role.all
    
    if @user.update_attributes(params[:user])
      flash[:success] = 'Users was successfully updated.'
      redirect_to( home_personal_url) 
    else
      render :action => :edit
    end
  end

  private
  def load_user
    @user = current_user
  end
end
