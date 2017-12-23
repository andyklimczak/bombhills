class RemoeEventsTable < ActiveRecord::Migration[4.2]
  def change
    drop_table :events
    drop_table :attendees_events
  end
end
