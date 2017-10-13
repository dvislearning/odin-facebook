class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.integer :requester_id
      t.integer :receiver_id

      t.timestamps
    end
    add_index :relationships, :requester_id
    add_index :relationships, :receiver_id
    add_index :relationships, [:requester_id, :receiver_id], unique: true    
  end
end
