class User::FavoritesController < ApplicationController

# set_movie呼び出し
  before_action :set_movie, only: [:create, :update]

  def create
    favorite = current_user.favorites.new(movie_id: @movie['id'])
    favorite.save
  end
 
  def destroy
    set_movie
    favorite = current_user.favorites.find_by(movie_id: @movie['id'])
    favorite.destroy
  end

  private

  def set_movie
    @movie = Movie.fetch_movie_data(params[:movie_id])
  end

end
