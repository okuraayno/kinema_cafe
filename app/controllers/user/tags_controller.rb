class User::TagsController < ApplicationController
  # 非ログイン時にアクセスするとログイン画面に遷移
  before_action :authenticate_user!
  
  def search
    @content = params[:tag]
    # @contentに代入された値がtagカラムに入っているレコードの中から、movie_idカラムの値を取得、重複を除いて配列として取得
    @movie_ids = Review.where(tag: @content).distinct(:movie_id).pluck(:movie_id)
    # @movie_ids内の各movie_idを使いAPI接続、movie_idに対応するデータを取得し@moviesに格納
    @movies = @movie_ids.map { |movie_id| Movie.fetch_movie_data(movie_id) }
    @movies = Kaminari.paginate_array(@movies).page(params[:page]).per(20)

    # 各映画に評価平均値、いいねの判定、レビューの判定を追加
    @movies.each do |movie|
      reviews = Review.where(movie_id: movie['id'])
      average_score = reviews.average(:star).to_f.round(1)
      favorited = current_user.favorites.exists?(movie_id: movie['id'])
      reviewed = current_user.reviews.exists?(movie_id: movie['id'])

      movie['average_score'] = average_score
      movie['favorited'] = favorited
      movie['reviewed'] = reviewed
    end

    render "user/tags/index"
  end

  private

  # 特定の映画情報を取得
  def self.fetch_movie_data(movie_id)
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API_KEY']}&language=ja"
    JSON.parse(Net::HTTP.get(URI.parse(url)))
  end
end
