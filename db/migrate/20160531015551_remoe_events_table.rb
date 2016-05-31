class RemoeEventsTable < ActiveRecord::Migration
  def change
    drop_table :events
    drop_table :attendees_events
  end
end
