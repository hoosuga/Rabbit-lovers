class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :room_id, null: false
      t.text :body, null: false
      t.timestamps
    end
  end
end
