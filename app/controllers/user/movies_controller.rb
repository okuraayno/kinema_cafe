class User::MoviesController < ApplicationController
  # 非ログイン時にアクセスするとログイン画面に遷移
  before_action :authenticate_user!
  before_action :set_movie, only: [:show]

  def index
    if params[:looking_for].present? # フォームから受け取った値で映画検索
      movie_title = params[:looking_for]
      movies = []
      (1..50).each do |page|
        url = "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['TMDB_API_KEY']}&language=ja&query=" + URI.encode_www_form_component(movie_title) + "&page=#{page}"
        response = Net::HTTP.get_response(URI.parse(url))
        if response.code == "200"
          result = JSON.parse(response.body)
          movies.concat(result["results"])
        end
      end
    else
      movies = [] # 検索フォームが空の場合
      (1..5).each do |page|
        url = "https://api.themoviedb.org/3/movie/now_playing?api_key=#{ENV['TMDB_API_KEY']}&language=ja&page=#{page}"
        response = Net::HTTP.get_response(URI.parse(url))
        if response.code == "200"
          result = JSON.parse(response.body)
          movies.concat(result["results"])
        end
      end
    end

    @movies = Kaminari.paginate_array(movies).page(params[:page]).per(20)

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

    @tags = fetch_top_tags
  end

  def show
    @movie_genre_names = Movie.fetch_genre_names(params[:id])
    @reviews = Review.where(movie_id: @movie['id']).page(params[:page]).per(10)
    if params[:latest]
      @reviews = @reviews.latest
    elsif params[:star_count]
      @reviews = @reviews.star_count
    end
    @average_score = @reviews.average(:star).to_f.round(1)
    @keywords = Language.get_data(@movie['overview'])
  end

  private

  def fetch_top_tags
    tag_count = Review.where.not(tag: [nil, ""]).group(:tag).count
    sorted_tags = tag_count.sort_by { |_, count| -count }
    sorted_tags.first(10).map(&:first)
  end

  def set_movie
    @movie = Movie.fetch_movie_data(params[:id])
  end

end
