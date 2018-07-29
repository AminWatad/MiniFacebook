class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :requester_id
      t.integer :requestee_id

      t.timestamps
    end
    add_index :requests, :requester_id
    add_index :requests, :requestee_id
    add_index :requests, [:requester_id, :requestee_id], unique: true
  end
end
