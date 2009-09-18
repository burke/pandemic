class AddVaccination < ActiveRecord::Migration
  def self.up
    add_column :users, :vaccination_date, :datetime
  end

  def self.down
    remove_column :users, :vaccination_date
  end
end
