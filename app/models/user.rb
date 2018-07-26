class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  has_many :posts
  has_many :activities, class_name: 'Activity'
  has_many :likes, foreign_key: 'liker_id'
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    # If you are using confirmable and the provider(s) you use validate emails, 
    # uncomment the line below to skip the confirmation emails.
    # user.skip_confirmation!
    end
  end

  def like(post)
    liker = Like.create(post_id: post.id, liker_id: self.id)
    likes << liker
    act = Activity.create(target_id: post.id, kind: "like", 
                          user_target_id: post.user_id)
    activities << act
  end

  def unlike(post)
    liker = Like.find_by(post_id: post.id, liker_id: self.id)
    act = Activity.find_by(target_id: post.id, kind: "like",
                           user_target_id: post.user_id)
    Like.delete(liker.id)
    activities.delete(act)
  end

  def likes?(post)
    liker = Like.find_by(post_id: post.id)
    !liker.nil?
  end
end
