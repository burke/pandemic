require File.dirname(__FILE__) + '/../../test_helper'

class Admin::RolesControllerTest < ActionController::TestCase
 context "on GET to /admin/role/index" do
    context "as a non-admin role" do
      setup do
        authenticate_as Factory(:user)
        get :index
      end
      should_respond_with :redirect
      should_set_the_flash_to /Access Denied/
    end
  
    context "as an admin role" do
      setup do
        authenticate_as Factory(:admin)

        get :index
      end
      should_respond_with :success
      should_not_set_the_flash
    end
  end

  context 'GET to /admin/role/new' do
    context 'as an admin role' do
      setup do
        authenticate_as Factory(:admin)

        get :new
      end

      should_respond_with :success
      should_render_template :new
      should_assign_to :role
    end

    context 'as a non-admin role' do
      setup do
        authenticate_as Factory(:user)
       
        get :new
      end
      should_respond_with :redirect
      should_redirect_to 'login_url'
      should_set_the_flash_to /Access Denied/
    end
  end

  context 'POST to /admin/role/create' do
    context 'As an admin role' do
      setup do
        authenticate_as Factory(:admin)
      
        post :create, :role => Factory.attributes_for(:role)
        @role = User.find(:all).last
      end
    
      should_redirect_to 'admin_role_url(@role)'
      should_set_the_flash_to /Role was successfully created./
    end
    context 'As non-admin role' do
      setup do
        authenticate_as Factory(:user)
      
        post :create, :role => Factory.attributes_for(:role)
        @role = User.find(:all).last
      end
    
      should_redirect_to 'login_url'
      should_set_the_flash_to /Access Denied/
    end
  end
  context 'GET to /admin/role/show' do
    context 'as an admin role' do
      setup do
        authenticate_as Factory(:admin) 
        @role = Factory(:role)
        get :show, :id => @role.id
      end
      should_respond_with :success
      should_render_template :show
      should_assign_to :role
    end
  
    context 'as a non-admin role' do
      setup do 
        authenticate_as Factory(:user)
        @role = Factory(:role)
        get :show, :id => @role.id
      end
      should_respond_with :redirect
      should_redirect_to 'login_url'
    end
  end

  context 'GET to /admin/role/edit' do
    context 'as an admin role' do
      setup do
        authenticate_as Factory(:admin)
        @role = Factory(:role)
        get :edit, :id => @role.id
      end
      should_respond_with :success
      should_render_template :edit
      should_assign_to :role
    end
    context 'as a non-admin role' do
      setup do
        authenticate_as Factory(:user)
        @role = Factory(:role)
        get :edit, :id => @role.id
      end
      should_respond_with :redirect
      should_redirect_to 'login_url'
    end
  end  
  context 'PUT to /admin/role/update' do
    context 'as an admin role' do
      setup do
        authenticate_as Factory(:admin)
        @role = Factory(:role)
        put :update, :id => @role.id, :user => Factory.attributes_for(:user)
      end
      should_respond_with :redirect
      should_redirect_to '[:admin,@role]'
    end
    context 'as a non-admin role' do
      setup do
        authenticate_as Factory(:user)
        @role = Factory(:role)
        put :update, :id => @role.id, :user => Factory.attributes_for(:user)
      end
      should_set_the_flash_to /Access Denied/
      should_redirect_to 'login_url'
    end
  end
  context 'DELETE to /admin/role/destroy' do
    context 'as an admin role' do
      setup do
        authenticate_as Factory(:admin)
        @role = Factory(:role)
        delete :destroy, :id => @role.id
      end
      should_set_the_flash_to /Role has been removed/
      should_redirect_to 'admin_roles_path'
    end
    context 'as a non-admin role' do 
      setup do
        authenticate_as Factory(:user)
        @role = Factory(:role)
        delete :destroy, :id => @role.id
      end
      should_set_the_flash_to /Access Denied/
      should_respond_with :redirect
      should_redirect_to 'login_url'
    end
  end
end
