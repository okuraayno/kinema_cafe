class Movie < ApplicationRecord

# APIからのデータ取得
  def self.fetch_movie_data(movie_id)
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API_KEY']}&language=ja"
    JSON.parse(Net::HTTP.get(URI.parse(url)))
  end

end
