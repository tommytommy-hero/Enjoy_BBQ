class Public::RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :ensure_current_user, only: [:edit, :update, :destroy]

  def new
    @recipe = Recipe.new
    @genres = Genre.all
    @recipe.ingredients.build
    2.times {
    @recipe.steps.build
    }
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id

    #下書きと投稿で分岐
    if @recipe.status == "draft"
      @recipe.save!(validate: false)
      redirect_to confirm_recipes_path
    else
      if @recipe.save
        redirect_to user_path(current_user)
      else
        @genres = Genre.all
        flash.now[:confirm] = "必須事項を全てご記入ください。"
        render 'new'
      end
    end
  end

  def index
    @genre = Genre.find_by(params[:genre_id])
    @genres = Genre.all
    #ジャンル毎の一覧表示
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      all_recipes = @genre.recipes.includes([:user])
    else
      all_recipes = Recipe.includes([:user])
    end
    @recipes = all_recipes.published.order(created_at: "DESC").page(params[:page])
  end

  def show
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new
  end

  #下書き一覧ページ
  def confirm
    @recipes = current_user.recipes.draft.order(created_at: "DESC").page(params[:page]).per(10)
  end

  #ランキング表示
  def rank
    @genre = Genre.find_by(params[:genre_id])
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      all_recipes = @genre.recipes
    else
      all_recipes = Recipe.all
    end
    @recipes = all_recipes.published.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @recipes = Kaminari.paginate_array(@recipes).page(params[:page]).per(6)
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
    #下書きと投稿で分岐
    if @recipe.status == "draft"
      @recipe.update(recipe_params)
      redirect_to recipes_path
    else
      if @recipe.update(recipe_params)
        redirect_to recipe_path(@recipe)
      else
        @genres = Genre.all
        flash.now[:confirm] = "必須事項を全てご記入ください。"
        render 'edit'
      end
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to user_path(current_user)
  end

  def search
    @results = @q.result.published.page(params[:page])
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
