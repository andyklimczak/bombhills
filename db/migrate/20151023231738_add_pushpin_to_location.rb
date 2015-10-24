class AddPushpinToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :pushpin, :string
  end
end
