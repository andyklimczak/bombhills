class CreateJoinTableAttendeesMeetups < ActiveRecord::Migration[4.2]
  def change
    create_join_table :attendees, :meetups do |t|
      # t.index [:attendee_id, :meetup_id]
      # t.index [:meetup_id, :attendee_id]
    end
  end
end
