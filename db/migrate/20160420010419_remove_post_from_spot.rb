class RemovePostFromSpot < ActiveRecord::Migration
  def change
    remove_reference :spots, :post, index: true
  end
end
