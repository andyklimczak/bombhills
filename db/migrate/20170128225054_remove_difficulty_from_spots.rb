class RemoveDifficultyFromSpots < ActiveRecord::Migration[4.2][5.0]
  def change
    remove_column :spots, :difficulty
  end
end
