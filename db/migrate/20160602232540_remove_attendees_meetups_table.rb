class RemoveAttendeesMeetupsTable < ActiveRecord::Migration[4.2]
  def change
    drop_table :attendees_meetups
  end
end
