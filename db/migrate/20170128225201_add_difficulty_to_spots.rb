class AddDifficultyToSpots < ActiveRecord::Migration[5.0]
  def change
    add_column :spots, :difficulty, :integer
  end
end
