class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.page(params[:page]).order(created_at: "DESC")
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:recipe_id)
    @recipes = Recipe.find(favorites)
    @recipes = Kaminari.paginate_array(@recipes).page(params[:page]).per(9)
  end

  def index
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

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name = "guestuser"
      redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end
