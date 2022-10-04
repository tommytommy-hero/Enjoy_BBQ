class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.order(created_at: "DESC")

    #いいね総数表示
    #@favorite = 0
    #@fav_recipes = current_user.recipes
    #@fav_recipes.each do |recipe|
     # @favorite += recipe.favorites.count
    #end
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:recipe_id)
    @recipes = Recipe.find(favorites)
  end

  def index
    @users = User.all
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

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name = "guestuser"
      redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end
