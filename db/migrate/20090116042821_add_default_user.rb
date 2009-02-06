
class AddDefaultUser < ActiveRecord::Migration
  def self.up
    u = User.create( :email => 'stefan.penner@gmail.com',
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
