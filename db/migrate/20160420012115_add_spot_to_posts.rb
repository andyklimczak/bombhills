class AddSpotToPosts < ActiveRecord::Migration[4.2]
  def change
    add_reference :posts, :spot
  end
end
