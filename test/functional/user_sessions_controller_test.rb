require File.dirname(__FILE__) + '/../test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
    #check for form
  end
  
  test "should create user session" do
    user = Factory(:user)
    user.confirm!
    post :create, :user_session => { :login => user.login, :password => user.password }
    assert user_session = UserSession.find
    assert_equal user, user_session.user
    assert_redirected_to dashboard_path
  end
  
  test "should destroy user session" do
    delete :destroy
    assert_nil UserSession.find
    assert_redirected_to login_path
  end
end
