class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_q, only: [:index, :search, :show]

  def index
    @users = User.order(created_at: "DESC").page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @all_recipes = @user.recipes.published
    @recipes = @user.recipes.order(created_at: "DESC").page(params[:page]).per(10)
    @results = @q.result
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render 'index'
    end
  end

  def search
   @results = @q.result.page(params[:page]).per(10)
  end

  private

  def set_q
    @q = User.ransack(params[:q])
  end

  def user_params
    params.require(:user).permit(:is_active)
  end
end
