class AddIndextoFrienships < ActiveRecord::Migration
  def change
    add_index :friendships, [:user_id, :friend_id]
  end
end
