class Public::RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :ensure_current_user, only: [:edit, :update, :destroy]

  def new
    @recipe = Recipe.new
    @genres = Genre.all
    @ingredients = @recipe.ingredients.build
    @steps = @recipe.steps.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to recipes_path
    else
      render 'new'
    end
  end

  def index
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      all_recipes = @genre.recipes
    else
      all_recipes = Recipe.all
    end
    @recipes = all_recipes.published.order(created_at: "DESC").page(params[:page])

  end

  def show
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new
  end

  def confirm
    @recipes = current_user.recipes.draft.order(created_at: "DESC").page(params[:page])
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @genres = Genre.all
    if @recipe.user == current_user
      render 'edit'
    else
      redirect_to recipes_path
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  def search
    @results = @q.result.page(params[:page])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:user_id, :name, :introduction, :genre_id, :recipe_image, :status,
    ingredients_attributes:[:id, :name, :amount, :_destroy],
    steps_attributes:[:id, :number, :explanation, :_destroy])
  end

  def ensure_current_user
    @recipe = Recipe.find(params[:id])
    unless @recipe.user == current_user
      redirect_to recipes_path
    end
  end

end
