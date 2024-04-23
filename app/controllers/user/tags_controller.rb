class User::TagsController < ApplicationController
  # 非ログイン時にアクセスするとログイン画面に遷移
  before_action :authenticate_user!
  
  def search
    @content = params[:tag]
    @reviews = Review.where(tag: @content).page(params[:page]).per(20)
    @movies = @reviews.map { |review| Movie.fetch_movie_data(review.movie_id) }
    render "user/tags/index"
  end

  private

  def self.fetch_movie_data(movie_id)
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API_KEY']}&language=ja"
    JSON.parse(Net::HTTP.get(URI.parse(url)))
  end

end