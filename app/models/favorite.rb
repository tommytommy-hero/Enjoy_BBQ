class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  #１つの投稿に対して１つしかいいねできない
  validates_uniqueness_of :recipe_id, scope: :user_id
end
