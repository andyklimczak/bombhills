class ChangeLocationUsernameToUserid < ActiveRecord::Migration
  def change
    remove_column :locations, :username
    add_reference :locations, :user, index: true
  end
end
