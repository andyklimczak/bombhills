class RemoveImageFromPost < ActiveRecord::Migration[4.2]
  def change
    remove_column :posts, :image
  end
end
