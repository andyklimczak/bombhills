class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.decimal :latitude, precision: 30, scale: 25
      t.decimal :longitude, precision: 30, scale: 25
      t.string :description
      t.string :title
      t.string :difficulty
      t.references :user, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
