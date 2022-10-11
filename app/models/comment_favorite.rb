class CommentFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  #１つの投稿に対して１つしかいいねできない
  validates_uniqueness_of :comment_id, scope: :user_id
end
