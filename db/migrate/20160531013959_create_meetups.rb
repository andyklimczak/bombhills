class CreateMeetups < ActiveRecord::Migration[4.2]
  def change
    create_table :meetups do |t|
      t.string :title
      t.string :description
      t.datetime :time
      t.references :spot, index: true, foreign_key: true
      t.references :user

      t.timestamps null: false
    end
  end
end
