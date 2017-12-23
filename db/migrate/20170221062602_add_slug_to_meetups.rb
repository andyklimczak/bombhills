class AddSlugToMeetups < ActiveRecord::Migration[4.2][5.0]
  def change
    add_column :meetups, :slug, :string
    add_index :meetups, :slug, unique: true
  end
end
