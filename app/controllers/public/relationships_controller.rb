class Public::RelationshipsController < ApplicationController
  #フォローする
  def create
    @user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
  end
  
  #フォロー解除
  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(params[:user_id])
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings.page(params[:page])
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers.page(params[:page])
  end

end
