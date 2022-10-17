class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_q, only: [:index, :search, :show]

  def index
    @users = User.order(created_at: "DESC").page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.order(created_at: "DESC")
    @results = @q.result
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to request.referer
      flash[:notice] = "内容を変更しました。"
    else
      render 'index'
    end
  end

  def search
   @results = @q.result
  end

  private

  def set_q
    @q = User.ransack(params[:q])
  end

  def user_params
    params.require(:user).permit(:is_active)
  end
end
