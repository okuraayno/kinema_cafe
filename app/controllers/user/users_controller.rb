class User::UsersController < ApplicationController

# set_movie呼び出し
  before_action :set_movie, only: [:show]

def show
  # 投稿ユーザーの特定
  @user = User.find(params[:id])
  # 上記で特定したユーザーが投稿したレビューを取得
  @reviews = @user.reviews
  # APIから取得したデータを格納する配列を作成
  @review_movies = []
  # レビューごとにAPIにアクセスしてデータを取得
  @reviews.each do |review|
    movie_id = review.movie_id
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API_KEY']}&language=ja"
    movie_data = JSON.parse(Net::HTTP.get(URI.parse(url)))
    @review_movies << movie_data
  end

  @favorites = @user.favorites

  @favorite_movies = []

  @favorites.each do |favorite|
    movie_id = favorite.movie_id
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API_KEY']}&language=ja"
    movie_data = JSON.parse(Net::HTTP.get(URI.parse(url)))
    @favorite_movies << movie_data
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

  def set_movie
    @movie = Movie.fetch_movie_data(params[:movie_id])
  end
  
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
