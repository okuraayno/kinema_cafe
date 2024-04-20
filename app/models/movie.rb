class Movie < ApplicationRecord

# 特定の映画データを取得
  def self.fetch_movie_data(movie_id)
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API_KEY']}&language=ja"
    JSON.parse(Net::HTTP.get(URI.parse(url)))
  end

# 特定の映画のジャンルを取得
  def self.fetch_genre_names(movie_id)
    movie_url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API_KEY']}&language=ja"
    genre_url = "https://api.themoviedb.org/3/genre/movie/list?api_key=#{ENV['TMDB_API_KEY']}&language=ja"

    movie_response = Net::HTTP.get(URI.parse(movie_url))
    genre_response = Net::HTTP.get(URI.parse(genre_url))

    movie = JSON.parse(movie_response)
    if movie.key?("genres") && movie["genres"].is_a?(Array)
      genre_names = movie["genres"].map { |genre| genre["name"] }.join(", ")
      return genre_names
    else
      return ""
    end
  end

end
