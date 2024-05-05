class User::KeywordsController < ApplicationController

  def search
    @keyword = params[:keyword]
    @movies = []
    (1..100).each do |page|
      url = "https://api.themoviedb.org/3/discover/movie?api_key=#{ENV['TMDB_API_KEY']}&language=ja&page=#{page}&include_adult=false"
      response = Net::HTTP.get_response(URI.parse(url))
      if response.code == "200"
        movies = JSON.parse(response.body)
        movies['results'].each do |movie|
          if movie['overview'].include?(@keyword) || movie['title'].include?(@keyword) # タイトルまたはあらすじにキーワードが含まれるか判別
            @movies << movie
          end
        end
      end
    end

    @movies = Kaminari.paginate_array(@movies).page(params[:page]).per(20)
    render "user/keywords/index"
  end

end