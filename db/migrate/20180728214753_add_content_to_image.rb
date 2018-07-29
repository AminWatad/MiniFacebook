class AddContentToImage < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :description, :text
  end
end
