class Activity < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }

  def text
    user = User.find(user_id)
    case self.kind
    when "post"
      "#{user.name} has created a new post."
    when "like"
      targeted = User.find(user_target_id)
      "#{user.name} liked #{targeted.name}'s post."
    when "comment"
      targeted = User.find(user_target_id)
      "#{user.name} commented on #{targeted.name}'s post." 
    end
  end

  def notification
    user = User.find(user_id)
    case self.kind
    when "like"
      "#{user.name} liked your post."
    when "comment"
      targeted = User.find(user_target_id)
      "#{user.name} commented on your post."
    end
  end
end
