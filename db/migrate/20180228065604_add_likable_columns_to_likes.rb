class AddLikableColumnsToLikes < ActiveRecord::Migration[5.1]
  def change
    add_column :likes, :likeable_id, :integer
    add_column :likes, :likeable_type, :string
  end
end
