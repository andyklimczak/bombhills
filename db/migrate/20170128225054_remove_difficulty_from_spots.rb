class RemoveDifficultyFromSpots < ActiveRecord::Migration[5.0]
  def change
    remove_column :spots, :difficulty
  end
end
