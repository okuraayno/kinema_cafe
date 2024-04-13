class User::MoviesController < ApplicationController

  def index
    if params[:looking_for]
      movie_title = params[:looking_for]
      url = "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['TMDB_API_KEY']}&language=ja&query=" + URI.encode_www_form_component(movie_title)
    else
      url = "https://api.themoviedb.org/3/movie/now_playing?api_key=#{ENV['TMDB_API_KEY']}&language=ja"
    end
    @movies = JSON.parse(Net::HTTP.get(URI.parse(url)))['results']
  end

  def show
    movie_id = params[:id]
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API_KEY']}&language=ja"
    @movie = JSON.parse(Net::HTTP.get(URI.parse(url)))
  end

end
