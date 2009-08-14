class CreateMeetingUsers < ActiveRecord::Migration
  def self.up
    create_table :meeting_users do |t|
      t.integer :meeting_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :meeting_users
  end
end
