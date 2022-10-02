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
    #byebug
    if @recipe.save
      #byebug
      redirect_to recipes_path
    else
      #byebug
      render 'new'
    end
  end

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def recipe_params
    params.require(:recipe).permit(:user_id, :name, :introduction, :genre_id, :recipe_image,
    ingredients_attributes:[:id, :name, :amount, :_destroy],
    steps_attributes:[:id, :number, :explanation, :_destroy])
  end

end
