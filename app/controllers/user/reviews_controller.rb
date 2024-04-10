class User::ReviewsController < ApplicationController

  def new
    movie_id = params[:movie_id]
    pp movie_id
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API_KEY']}&language=ja"
    @movie = JSON.parse(Net::HTTP.get(URI.parse(url)))
    @review = Review.new
  end

  def create
    movie_id = params[:id]
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API_KEY']}&language=ja"
    @movie = JSON.parse(Net::HTTP.get(URI.parse(url)))
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to movie_path(@movie), notice: "You have created book successfully."
    else
      render 'new'
    end
  end

  private

  def review_params
    params.require(:review).permit(:movie_id, :review_title, :review_comment, :star)
  end

end
