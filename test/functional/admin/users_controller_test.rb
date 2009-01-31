require File.dirname(__FILE__) + '/../../test_helper' 

class Admin::UsersControllerTest < ActionController::TestCase
  context "on GET to /admin/index" do
    context "as an unconfirmed user" do
      setup do
        @user = Factory(:user,:confirmed => false)
        login_user
      end
      should_set_the_flash_to /Bad email or password/
      should_render_template :new
    end

    context "as a confirmed user" do
      setup do
        @user = Factory(:user,:confirmed => true)
        login_user do
          get :index
        end
      end
      should_set_the_flash_to /Logged in successfully/
      should_respond_with :redirect
      should_redirect_to "home_url"
    end
  end
end
