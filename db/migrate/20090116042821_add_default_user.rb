require 'user'
require 'role'
require 'user_role'
class AddDefaultUser < ActiveRecord::Migration
  def self.up
    u = User.create( :email => 'test@53cr.com',
                     :password => 'test', 
                     :password_confirmation => 'test')
    u.confirm!
    u.roles.create( :name => 'admin',
                    :description => 'duh')

    u.save
  end

  def self.down
  end
end
