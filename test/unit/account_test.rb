require File.dirname(__FILE__) + '/../test_helper'

class AccountTest < ActiveSupport::TestCase
  should_have_db_column :name
  should_have_db_column :description
  should_have_db_column :balance
end
