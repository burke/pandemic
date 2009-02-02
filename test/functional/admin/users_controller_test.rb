require File.dirname(__FILE__) + '/../../test_helper' 

class Admin::UsersControllerTest < ActionController::TestCase
  context "on GET to /admin/user/index" do
    context "as a non-admin user" do
      setup do
        authenticate_as Factory(:user)
        get :index
      end
      should_respond_with :redirect
      should_set_the_flash_to /Access Denied/
    end
  
    context "as an admin user" do
      setup do
        authenticate_as Factory(:admin)

        get :index
      end
      should_respond_with :success
      should_not_set_the_flash
    end
  end

  context 'GET to /admin/user/new' do
    context 'as an admin user' do
      setup do
        authenticate_as Factory(:admin)

        get :new
      end

      should_respond_with :success
      should_render_template :new
      should_assign_to :user
    end

    context 'as a non-admin user' do
      setup do
        authenticate_as Factory(:user)
       
        get :new
      end
      should_respond_with :redirect
      should_redirect_to 'login_url'
      should_set_the_flash_to /Access Denied/
    end
  end

  context 'POST to /admin/user/create' do
    context 'As an admin user' do
      setup do
        authenticate_as Factory(:admin)
      
        post :create, :user => Factory.attributes_for(:user)
        @user = User.find(:all).last
      end
    
      should_redirect_to 'admin_user_url(@user)'
      should_set_the_flash_to /User was successfully created./
    end
    context 'As non-admin user' do
      setup do
        authenticate_as Factory(:user)
      
        post :create, :user => Factory.attributes_for(:user)
        @user = User.find(:all).last
      end
    
      should_redirect_to 'login_url'
      should_set_the_flash_to /Access Denied/
    end
  end
  context 'GET to /admin/user/show' do
    context 'as an admin user' do
      setup do
        authenticate_as Factory(:admin) 
        @user = Factory(:user)
        get :show, :id => @user.id
      end
      should_respond_with :success
      should_render_template :show
      should_assign_to :user
    end
  
    context 'as a non-admin user' do
      setup do 
        authenticate_as Factory(:user)
        @user = Factory(:user)
        get :show, :id => @user.id
      end
      should_respond_with :redirect
      should_redirect_to 'login_url'
    end
  end

  context 'GET to /admin/user/edit' do
    context 'as an admin user' do
      setup do
        authenticate_as Factory(:admin)
        @user = Factory(:user)
        get :edit, :id => @user.id
      end
      should_respond_with :success
      should_render_template :edit
      should_assign_to :user
    end
    context 'as a non-admin user' do
      setup do
        authenticate_as Factory(:user)
        @user = Factory(:user)
        get :edit, :id => @user.id
      end
      should_respond_with :redirect
      should_redirect_to 'login_url'
    end
  end  
  context 'PUT to /admin/user/update' do
    context 'as an admin user' do
      setup do
        authenticate_as Factory(:admin)
        @user = Factory(:user)
        put :update, :id => @user.id, :user => Factory.attributes_for(:user)
      end
      should_respond_with :redirect
      should_redirect_to '[:admin,@user]'
    end
    context 'as a non-admin user' do
      setup do
        authenticate_as Factory(:user)
        @user = Factory(:user)
        put :update, :id => @user.id, :user => Factory.attributes_for(:user)
      end
      should_set_the_flash_to /Access Denied/
      should_redirect_to 'login_url'
    end
  end
  context 'DELETE to /admin/user/destroy' do
    context 'as an admin user' do
      setup do
        authenticate_as Factory(:admin)
        @user = Factory(:user)
        delete :destroy, :id => @user.id
      end
      should_set_the_flash_to /User .+@.+.+ was removed/
      should_redirect_to 'admin_users_path'
    end
    context 'as a non-admin user' do 
      setup do
        authenticate_as Factory(:user)
        @user = Factory(:user)
        delete :destroy, :id => @user.id
      end
      should_set_the_flash_to /Access Denied/
      should_respond_with :redirect
      should_redirect_to 'login_url'
    end
  end
end
