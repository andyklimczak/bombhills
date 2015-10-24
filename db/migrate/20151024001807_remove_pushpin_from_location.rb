class RemovePushpinFromLocation < ActiveRecord::Migration
  def change
    remove_column :locations, :pushpin, :string
  end
end
