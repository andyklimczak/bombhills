class CreateMeetupAttendees < ActiveRecord::Migration
  def change
    create_table :meetup_attendees do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :meetup, index: true, foreign_key: true

      t.timestamps
    end
  end
end
