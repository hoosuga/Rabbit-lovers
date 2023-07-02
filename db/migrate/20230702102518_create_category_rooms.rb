class CreateCategoryRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :category_rooms do |t|
      t.integer :room_id, null: false
      t.integer :category_id, null: false
      t.timestamps
    end
  end
end
