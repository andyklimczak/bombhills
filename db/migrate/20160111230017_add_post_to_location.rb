class AddPostToLocation < ActiveRecord::Migration
  def change
    add_reference :locations, :post, index: true, foreign_key: true
  end
end
