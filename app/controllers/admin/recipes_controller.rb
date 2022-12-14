class Admin::RecipesController < ApplicationController
  before_action :authenticate_admin!

  def show
    @recipe = Recipe.find(params[:id])
  end

  def index
    @recipes = Recipe.published.includes([:user]).order(created_at: "DESC").page(params[:page]).per(10)
  end

  def search
    @results = @q.result.page(params[:page])
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to admin_recipes_path
  end
end
