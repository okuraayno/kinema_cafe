class User::HomesController < ApplicationController

  def top
    @reviews = Review.order(created_at: :desc).limit(3)
    @favorites = Favorite.order(created_at: :desc).limit(3)
  end

  private

  def set_movie
    @movie = Movie.fetch_movie_data(params[:movie_id])
  end

end
