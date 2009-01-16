require File.dirname(__FILE__) + '/../../test_helper'

class Admin::UsersControllerTest < ActionController::TestCase

  def setup
    @users = Factory(:users)
  end

 
end
