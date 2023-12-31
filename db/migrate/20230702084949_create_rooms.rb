class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end
