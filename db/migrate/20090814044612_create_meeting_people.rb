class CreateMeetingPeople < ActiveRecord::Migration
  def self.up
    create_table :meeting_people do |t|
      t.integer :meeting_id
      t.integer :person_id

      t.timestamps
    end
  end

  def self.down
    drop_table :meeting_people
  end
end
