class ChangeLatandLongForLocationToDecimal < ActiveRecord::Migration
  def change
    change_column :locations, :latitude, :decimal, :precision => 25, :scale => 20
    change_column :locations, :longitude, :decimal, :precision => 25, :scale => 20
  end
end
