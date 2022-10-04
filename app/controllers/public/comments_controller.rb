class Public::CommentsController < ApplicationController

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
end
