class Public::UsersController < ApplicationController
  
  
  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.order(created_at: "DESC")
    @favorite = 0
    @recipes.each do |recipe|
      @favorite += recipe.favorites.size
    end
    
    
    
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

end
