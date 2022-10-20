class Admin::RecipesController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @recipe = Recipe.find(params[:id])
  end

  def index
    @recipes = Recipe.includes([:user]).order(created_at: "DESC").page(params[:page])
  end

  def search
    @results = @q.result.page(params[:page])
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end
end
