class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :kind
      t.references :user, foreign_key: true
      t.integer :user_target_id
      t.integer :target_id

      t.timestamps
    end
  end
end
