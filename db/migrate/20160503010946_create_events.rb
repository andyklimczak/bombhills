class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.time :datetime
      t.references :owner
      t.references :spot

      t.timestamps null: false
    end
  end
end
