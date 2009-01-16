require File.dirname(__FILE__) + '/../test_helper'

class RoleTest < ActiveSupport::TestCase
  should_have_db_column :name
  should_have_db_column :description
  
  should_have_many :user_roles
  should_have_many :users, :through => :user_roles
end
