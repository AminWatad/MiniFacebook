class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :liker_id, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
    add_index :likes, :liker_id
    add_index :likes, [:liker_id, :post_id], unique: true
  end
end
