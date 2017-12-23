class CreateJoinTableAttendeesEvents < ActiveRecord::Migration[4.2]
  def change
    create_join_table :attendees, :events do |t|
      # t.index [:attendee_id, :event_id]
      # t.index [:event_id, :attendee_id]
    end
  end
end
