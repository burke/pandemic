class AddLocationToMeeting < ActiveRecord::Migration
  def self.up
    add_column :meetings, :location_id, :integer

  end

  def self.down
  end
end
