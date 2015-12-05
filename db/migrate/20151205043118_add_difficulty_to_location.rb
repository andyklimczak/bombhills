class AddDifficultyToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :difficulty, :integer
  end
end
