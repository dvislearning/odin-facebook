class RemoveIndexAndPostsColumnFromLikes < ActiveRecord::Migration[5.1]
  def change
    remove_column :likes, :post_id, :integer
  end
  
  remove_index :likes, [:user_id, :post_id]
end
