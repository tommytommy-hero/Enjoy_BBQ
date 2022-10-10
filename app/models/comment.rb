class Comment < ApplicationRecord
  belongs_to :recipe
  belongs_to :user

  validates :recipe_comment, length: { maximum: 100 }

end
