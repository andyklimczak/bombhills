class AddVideoUrlToPosts < ActiveRecord::Migration[4.2]
  def change
    add_column :posts, :video_url, :string
  end
end
