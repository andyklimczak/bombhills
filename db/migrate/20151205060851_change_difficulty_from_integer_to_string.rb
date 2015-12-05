class ChangeDifficultyFromIntegerToString < ActiveRecord::Migration
  def change
    change_column :locations, :difficulty, :string
  end
end
