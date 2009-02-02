require File.dirname(__FILE__) + '/../test_helper'

class SessionsControllerTest < ActionController::TestCase
 should_filter_params :password

 context "on GET to /sessions/new" do
   setup { get :new }
        
   should_respond_with :success
   should_render_template :new
   should_not_set_the_flash

   should 'display a "sign in" form' do
     assert_select "form[action=#{session_path}][method=post]", 
                   true, 
                   "There must be a form to sign in" do
                      assert_select "input[type=text][name=?]", 
                                    "session[email]",
                                    true, 
                                    "There must be an email field"

                      assert_select "input[type=password][name=?]", 
                                    "session[password]", 
                                    true, 
                                    "There must be a password field"

                      assert_select "input[type=checkbox][name=?]", 
                                    "session[remember_me]", 
                                    true, 
                                    "There must be a 'remember me' check box"

                      assert_select "input[type=submit]", 
                                    true, 
                                    "There must be a submit button"
                  end 
    end

    context "Given a confirmed user" do
      setup { @user = Factory(:user, :confirmed => true) }
            
      context "that is logging in" do
        setup do
            post :create, 
                 :session => { :email       => @user.email,
                               :password    => @user.password,
                               :remember_me => false }
        end
        should_set_the_flash_to "Logged in successfully" 
      end
      context "that is logging in" do
        setup do
          post :create, 
               :session => { :email       => @user.email,
                             :password    => @user.password,
                             :remember_me => true }
        end
        should_set_the_flash_to "Logged in successfully"
        should "be remembered for 2 weeks" do
        # todo
        end 
      end
    end
   
    context "Given a registered but not confirmed user" do
      setup { @user = Factory( :user, :confirmed => false) }

      context "with good credentials" do
        setup do     
          post :create, 
               :session => { :email    => @user.email,
                             :password => @user.password }
        end
        should_set_the_flash_to "Bad email or password." 
      end
    end
  end
end
