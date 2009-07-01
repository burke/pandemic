require File.dirname(__FILE__) + '/../test_helper'

class UsersControllerTest < ActionController::TestCase
  should_filter_params :password, :password_confirmation
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => Factory.attributes_for(:user)
    end
    assert_redirected_to login_path
  end
end

