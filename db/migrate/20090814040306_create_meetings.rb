class CreateMeetings < ActiveRecord::Migration
  def self.up
    create_table :meetings do |t|
      t.integer :owner_id
      t.integer :duration
      t.date :date

      t.timestamps
    end
  end

  def self.down
    drop_table :meetings
  end
end
