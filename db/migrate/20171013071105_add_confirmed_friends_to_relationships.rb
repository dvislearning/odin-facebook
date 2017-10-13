class AddConfirmedFriendsToRelationships < ActiveRecord::Migration[5.1]
  def change
    add_column :relationships, :confirmed_friends, :boolean, default: false
  end
end
