class Batch::DataReset

  #ゲストユーザーの初期化
  def self.data_reset
    user = User.find_by(email: 'guest@example.com')
    user.recipes.destroy_all
    user.comments.destroy_all
    user.favorites.destroy_all
    user.comment_favorites.destroy_all
    user.relationships.destroy_all
    p"ゲストユーザーがリセットされました"
  end
end