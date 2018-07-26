class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 200 }
  default_scope -> { order(created_at: :desc) } 
  belongs_to :user
  has_many :likes
  has_many :comments
end
