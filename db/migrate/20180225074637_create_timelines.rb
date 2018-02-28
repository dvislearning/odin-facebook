class CreateTimelines < ActiveRecord::Migration[5.1]
  def change
    create_table :timelines do |t|
      t.integer :user_id
      t.integer :post_id
      t.integer :picture_id

      t.timestamps
    end
  end
end
