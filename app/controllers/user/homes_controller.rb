class User::HomesController < ApplicationController

  def top
    # 新着レビューを3件取得
    @reviews = Review.order(created_at: :desc).limit(3)
    # 新着いいねを3件取得
    @favorites = Favorite.order(created_at: :desc).limit(3)
  end

  private

  # 特定の映画情報を取得
  def set_movie
    @movie = Movie.fetch_movie_data(params[:movie_id])
  end
end
