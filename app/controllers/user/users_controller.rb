class User::UsersController < ApplicationController
  
def show
  # 投稿ユーザーの特定
  @user = User.find(params[:id])
  # 上記で特定したユーザーが投稿したレビューを取得
  @reviews = @user.reviews
  # APIから取得したデータを格納する配列を作成
  @movie = []
  # レビューごとにAPIにアクセスしてデータを取得
  @reviews.each do |review|
    movie_id = review.movie_id
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API_KEY']}&language=ja"
    movie_data = JSON.parse(Net::HTTP.get(URI.parse(url)))
    @movie << movie_data
  end
end
  
  def edit
    is_matching_login_user
    @user = User.find(params[:id])
  end

  def update
    is_matching_login_user
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end


  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
  
end
