require File.dirname(__FILE__) + '/../test_helper'

class UsersControllerTest < ActionController::TestCase
  should_filter_params :password

  context "on GET to /users/new" do
    setup { get :new }
        
    should_respond_with :success
    should_render_template :new
    should_not_set_the_flash

    should "display a form to register" do
      assert_select "form[method=post][action=/users]", 
                     true, "There must be a form to register" do
         assert_select "input[type=text][name=?]", 
                       "user[email]", true, "There must be an email field"
         assert_select "input[type=password][name=?]", 
                       "user[password]", true, "There must be a password field"
         assert_select "input[type=password][name=?]", 
                       "user[password_confirmation]", true, "There must be a password confirmation field"                      
         assert_select "input[type=submit]", true, 
                       "There must be a submit button"
      end
    end
  end

  context "on Post to /users" do
    context "with valid attributes" do
      setup do
        attributes = Factory.attributes_for(:user)
        post :create, :user => attributes
      end
      #should_respond_with :success
      should_redirect_to 'login_url'
      should_set_the_flash_to "You will receive an email within the next few minutes. It contains instructions for you to confirm your account."
    end
    context "with invalid" do
      context "email" do
        setup do
          attributes = Factory.attributes_for(:user,:email => "apple")
          post :create, :user => attributes
        end
        #should_respond_with :success
        should_render_template :new 
      end
      context "password" do
        setup do
          attributes = Factory.attributes_for(:user,:password => 'non_matching')
          post :create, :user => attributes
        end
        #should_respond_with :failure
        should_render_template :new
      end
    end
  end   
end

