class User::ReviewsController < ApplicationController

  def show
    movie_id = params[:movie_id]
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API_KEY']}&language=ja"
    @movie = JSON.parse(Net::HTTP.get(URI.parse(url)))
    @review = Review.find(params[:id])
  end

  def new
    movie_id = params[:movie_id]
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API_KEY']}&language=ja"
    @movie = JSON.parse(Net::HTTP.get(URI.parse(url)))
    @review = Review.new
  end

  def create
    movie_id = params[:movie_id]
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API_KEY']}&language=ja"
    movie = JSON.parse(Net::HTTP.get(URI.parse(url)))
    review = Review.new(review_params)
    review.user_id = current_user.id
    if review.save
      redirect_to movie_path(movie['id']) , notice: "You have created book successfully."
    else
      render 'new'
    end
  end
  
  def edit
    movie_id = params[:movie_id]
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API_KEY']}&language=ja"
    @movie = JSON.parse(Net::HTTP.get(URI.parse(url)))
    @review = Review.find(params[:id])
  end

  def update
    movie_id = params[:movie_id]
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API_KEY']}&language=ja"
    movie = JSON.parse(Net::HTTP.get(URI.parse(url)))
    review = Review.find(params[:id])
    if review.update(review_params)
      redirect_to movie_path(movie['id']), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :movie_id, :title, :comment, :star)
  end

end
