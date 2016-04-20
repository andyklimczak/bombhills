class AddSpotToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :spot
  end
end
