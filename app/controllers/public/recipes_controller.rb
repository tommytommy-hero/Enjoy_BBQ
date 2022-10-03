class Public::RecipesController < ApplicationController
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
    @recipes = Recipe.published
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def confirm
    @recipes = current_user.recipes.draft
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

  private

  def recipe_params
    params.require(:recipe).permit(:user_id, :name, :introduction, :genre_id, :recipe_image, :status,
    ingredients_attributes:[:id, :name, :amount, :_destroy],
    steps_attributes:[:id, :number, :explanation, :_destroy])
  end

end
