class User::KeywordsController < ApplicationController

  def search
    @keyword = params[:keyword]
    @movies = []
    threads = []

    (1..300).each do |page|
      threads << Thread.new(page) do |p| # 1ページ1スレッドで並行してデータを取得する
        url = "https://api.themoviedb.org/3/discover/movie?api_key=#{ENV['TMDB_API_KEY']}&language=ja&page=#{p}&include_adult=false&include_video=false"
        response = Net::HTTP.get_response(URI.parse(url))
        if response.code == "200"
          movies = JSON.parse(response.body)
          movies['results'].each do |movie|
            if movie['overview'].include?(@keyword) # あらすじにキーワードが含まれるか判別
              @movies << movie
            end
          end
        end
      end
    end

    threads.each(&:join)  # 全てのスレッドの終了を待つ
    @movies = Kaminari.paginate_array(@movies).page(params[:page]).per(20)
    render "user/keywords/index"
  end

end