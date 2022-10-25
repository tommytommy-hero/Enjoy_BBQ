class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit]
  before_action :ensure_guest_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @all_recipes = @user.recipes.published
    @genre = Genre.find_by(params[:genre_id])
    @genres = Genre.all
    @recipes = @user.recipes.published
    #ジャンル毎の一覧表示
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      all_recipes = @recipes.where(genre_id: params[:genre_id])
    else
      all_recipes = @recipes
    end
    @total_recipes = all_recipes.order(created_at: "DESC").page(params[:page])
  end

  #マイリスト一覧ページ
  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:recipe_id)
    @recipes = Recipe.where(id: favorites)
    @genres = Genre.all

    @genre = Genre.find_by(params[:genre_id])
    if params[:genre_id]
      all_recipes = @recipes.where(genre_id: params[:genre_id])
    else
      all_recipes = @recipes
    end
    @all_recipes = Kaminari.paginate_array(all_recipes).page(params[:page]).per(9)
  end

  def index
    @genres = Genre.all
    @users = User.where.not(id: current_user.id).page(params[:page])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  private

  def user_params
  params.require(:user).permit(:name, :introduction, :user_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  #ゲストログイン
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user)
    end
  end

end
