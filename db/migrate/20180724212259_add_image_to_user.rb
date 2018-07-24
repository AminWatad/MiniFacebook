class AddImageToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image, :string, null: false,
      default: "http://s3.amazonaws.com/37assets/svn/765-default-avatar.png"
  end
end
