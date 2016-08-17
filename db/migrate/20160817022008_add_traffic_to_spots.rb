class AddTrafficToSpots < ActiveRecord::Migration[5.0]
  def change
    add_column :spots, :traffic, :string
  end
end
