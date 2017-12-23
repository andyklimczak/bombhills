class AddDifficultyToSpots < ActiveRecord::Migration[4.2][5.0]
  def change
    add_column :spots, :difficulty, :integer
  end
end
