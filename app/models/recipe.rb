class Recipe < ApplicationRecord

  belongs_to :user
  belongs_to :genre

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :favorited_users, through: :favorites, source: :user
  has_many :ingredients, dependent: :destroy
  has_many :steps, dependent: :destroy

  validates :name, length: { maximum: 30 }, presence: true
  validates :introduction, length: { maximum: 200 }, presence: true

  #子モデルであるingredientとstepも保存ができる
  accepts_nested_attributes_for :ingredients, :steps, allow_destroy: true

  has_one_attached :recipe_image

  enum status: { published: 0, draft: 1 }

  def get_recipe_image
    (recipe_image.attached?) ? recipe_image : 'no-image-icon.jpg'
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
