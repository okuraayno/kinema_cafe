class Movie < ApplicationRecord

# 特定の映画データを取得
  def self.fetch_movie_data(movie_id)
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API_KEY']}&language=ja"
    JSON.parse(Net::HTTP.get(URI.parse(url)))
  end

# 特定の映画のジャンルを取得
  def self.fetch_genre_names(movie_id)
    movie_data = fetch_movie_data(movie_id)

    if movie_data.key?("genres") && movie_data["genres"].is_a?(Array)
      genre_names = movie_data["genres"].map { |genre| genre["name"] }.join(", ")
      return genre_names
    else
      return ""
    end
  end

end
