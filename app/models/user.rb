class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  has_many :posts
  has_many :activities, class_name: 'Activity'
  has_many :likes, foreign_key: 'liker_id'
  has_many :comments
  has_many :images
  has_many :user_requests, class_name: "Request", 
                          foreign_key: "requester_id"
  has_many :user_requested, class_name: "Request", 
                            foreign_key: "requestee_id"
  has_many :requesters, through: :user_requests, source: :requestee
  has_many :requested, through: :user_requested, source: :requester

  has_many :relationships
  has_many :friends, through: :relationships
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
  def request(user)
    requested << user
  end
  
  def unrequest(user)
    requested.delete(user)
  end 
  
  def requested?(user)
    requested.include?(user)
  end
  
  def requested_by?(user)
    requesters.include?(user)
  end
  
  def befriend(user)
    friends << user
  end

  def unfriend(user)
    friends.delete(user)
  end

  def friend?(user)
    friends.include?(user)
  end

  def like(post)
    liker = Like.create(post_id: post.id, liker_id: self.id)
    likes << liker
    act = Activity.create(target_id: post.id, kind: "like", 
                          user_target_id: post.user_id, 
                          user_id: self.id)
    activities << act
  end

  def unlike(post)
    liker = Like.find_by(post_id: post.id, liker_id: self.id)
    act = Activity.find_by(target_id: post.id, kind: "like",
                           user_target_id: post.user_id)
    Like.delete(liker.id)
    activities.destroy(act)
  end

  def likes?(post)
    liker = Like.find_by(post_id: post.id, liker_id: self.id)
    !liker.nil?
  end

  def notifications
    nots = Activity.where(user_target_id: self.id)
    nots.first(10)
  end

  def feed
    friends_ids = "SELECT friend_id FROM relationships
                   WHERE user_id = :user_id"
    Post.where("user_id IN (#{friends_ids})
               OR user_id = :user_id", user_id: id)
  end
end
