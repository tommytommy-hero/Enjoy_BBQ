class Public::CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :ensure_current_user, only: [:destroy]
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = current_user.comments.new(comment_params)
    @comment.recipe_id = @recipe.id
    @comment.save
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:recipe_comment)
  end

  def ensure_current_user
    @comment = Comment.find(params[:id])
    unless @comment.user == current_user
      redirect_to recipes_path
    end
  end
end
