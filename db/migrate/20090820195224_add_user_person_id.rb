class AddUserPersonId < ActiveRecord::Migration
  def self.up

    add_column :users, :person_id, :integer

  end

  def self.down
  end
end
