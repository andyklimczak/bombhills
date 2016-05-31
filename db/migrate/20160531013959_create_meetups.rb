class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.string :title
      t.string :description
      t.datetime :time
      t.references :spot, index: true, foreign_key: true
      t.references :owner

      t.timestamps null: false
    end
  end
end
