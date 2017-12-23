class RemovePostFromSpot < ActiveRecord::Migration[4.2]
  def change
    remove_reference :spots, :post, index: true
  end
end
