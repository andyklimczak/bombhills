class AddTypeToPosts < ActiveRecord::Migration[4.2]
  def change
    add_column :posts, :type, :string
  end
end
