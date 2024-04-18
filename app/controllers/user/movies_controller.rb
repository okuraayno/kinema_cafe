class User::MoviesController < ApplicationController

  def index
    if params[:looking_for].present?
      movie_title = params[:looking_for]
      movies = search_movies(movie_title)
    else
      movies = fetch_now_playing_movies
    end
    @movies = Kaminari.paginate_array(movies).page(params[:page]).per(20)
  end

  def show
    @movie = Movie.fetch_movie_data(params[:id]) # ここで@movieをセットする
    @movie_genre_names = Movie.fetch_genre_names(params[:id])
    @reviews = Review.where(movie_id: @movie['id'])
    @average_score = @reviews.average(:star).to_f.round(1)
  end

  private

  def search_movies(title)
    movies = []
    (1..5).each do |page|
      url = "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['TMDB_API_KEY']}&language=ja&query=" + URI.encode_www_form_component(title) + "&page=#{page}"
      response = Net::HTTP.get_response(URI.parse(url))
      if response.code == "200"
        result = JSON.parse(response.body)
        movies.concat(result["results"])
      end
    end
    movies
  end

  def fetch_now_playing_movies
    movies = []
    (1..5).each do |page|
      url = "https://api.themoviedb.org/3/movie/now_playing?api_key=#{ENV['TMDB_API_KEY']}&language=ja&page=#{page}"
      response = Net::HTTP.get_response(URI.parse(url))
      if response.code == "200"
        result = JSON.parse(response.body)
        movies.concat(result["results"])
      end
    end
    movies
  end

  def set_movie
    @movie = Movie.fetch_movie_data(params[:id]) # params[:id]を使用する
  end

  def set_movie_genre_names
    @movie_genre_names = Movie.fetch_genre_names(params[:id]) # params[:id]を使用する
  end
  
end