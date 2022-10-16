class Recipe < ApplicationRecord

  belongs_to :user
  belongs_to :genre, optional: true

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_many :favorited_users, through: :favorites, source: :user
  has_many :ingredients, dependent: :destroy
  has_many :steps, dependent: :destroy

  validates :name, presence: true
  validates :introduction, length: { maximum: 200 }, presence: true
  
  #子モデルであるingredientとstepも保存ができる
  accepts_nested_attributes_for :ingredients, :steps, allow_destroy: true

  has_one_attached :recipe_image

  enum status: { published: 0, draft: 1 }

  def get_recipe_image(width, height)
    unless recipe_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      recipe_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    recipe_image.variant(resize_to_fill: [width, height]).processed
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
