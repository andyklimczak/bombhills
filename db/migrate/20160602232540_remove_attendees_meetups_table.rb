class RemoveAttendeesMeetupsTable < ActiveRecord::Migration
  def change
    drop_table :attendees_meetups
  end
end
