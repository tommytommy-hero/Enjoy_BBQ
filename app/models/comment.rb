class Comment < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  has_many :comment_favorites, dependent: :destroy

  validates :recipe_comment, length: { maximum: 100 }, presence: true
  def comment_favorited_by?(user)
    comment_favorites.exists?(user_id: user.id)
  end
end
