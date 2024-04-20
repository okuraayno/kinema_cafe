class User::TagsController < ApplicationController
  
  def search
    @content = params[:tag]
    @review_ids = Review.where("tag = :content", content: @content).pluck(:id)
    @movie_ids = Review.find(@review_ids).pluck(:movie_id).uniq
    @movies = @movie_ids.map { |movie_id| Movie.fetch_movie_data(movie_id) }
    render "user/tags/index"
  end

  private

  def self.fetch_movie_data(movie_id)
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API_KEY']}&language=ja"
    JSON.parse(Net::HTTP.get(URI.parse(url)))
  end

end