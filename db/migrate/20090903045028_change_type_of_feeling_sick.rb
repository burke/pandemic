class ChangeTypeOfFeelingSick < ActiveRecord::Migration
  def self.up
    remove_column :statuses, :feeling_sick
    add_column :statuses, :feeling_sick, :string
  end

  def self.down
  end
end
