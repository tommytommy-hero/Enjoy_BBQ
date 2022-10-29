class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, uniqueness:true
  validates :introduction, length: { maximum: 200 }

  has_many :recipes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :favorited_recipes, through: :favorites, source: :recipe
  has_many :contacts, dependent: :destroy
  has_many :comment_favorites, dependent: :destroy

  #フォロー関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  #フォロー一覧、フォロワー一覧
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  #フォロー処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  #フォロー解除処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  #フォロー判定
  def following?(user)
    followings.include?(user)
  end

  has_one_attached :user_image

  def get_user_image
    (user_image.attached?) ? user_image : 'no_image.jpg'
  end

  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

end
