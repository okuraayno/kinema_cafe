class User::KeywordsController < ApplicationController  

  def search
    @keyword = params[:keyword]
    @movies = []

    (1..5).each do |page|
      url = "https://api.themoviedb.org/3/movie/now_playing?api_key=#{ENV['TMDB_API_KEY']}&language=ja&page=#{page}"
      response = Net::HTTP.get_response(URI.parse(url))
      if response.code == "200"
        movies = JSON.parse(response.body)
        movies['results'].each do |movie|
          if movie['overview'].include?(@keyword)
            @movies << movie
          end
        end
      end
    end

    render "user/keywords/index"
  end

end
