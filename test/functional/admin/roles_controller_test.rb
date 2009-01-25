require File.dirname(__FILE__) + '/../../test_helper'

class RolesControllerTest < ActionController::TestCase

  def setup
    @roles = Factory(:roles)
  end
end
