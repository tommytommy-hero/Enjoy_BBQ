class Public::CommentFavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = Comment.find(params[:comment_id])
    comment_favorite = current_user.comment_favorites.new(comment_id: @comment.id)
    comment_favorite.save
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @comment = Comment.find(params[:comment_id])
    comment_favorite = current_user.comment_favorites.find_by(comment_id: @comment.id)
    comment_favorite.destroy
  end
end
