class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

end
