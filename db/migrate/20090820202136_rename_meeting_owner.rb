class RenameMeetingOwner < ActiveRecord::Migration
  def self.up
    rename_column :meetings, :owner_id, :user_id
  end

  def self.down
  end
end
