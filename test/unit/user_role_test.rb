require File.dirname(__FILE__) + '/../test_helper'

class UserRoleTest < ActiveSupport::TestCase
  should_have_db_column :user_id
  should_have_db_column :role_id
  
  should_belong_to :user
  should_belong_to :role
end
