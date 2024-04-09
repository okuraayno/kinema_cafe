class User::ReviewsController < ApplicationController
  
  def new
    @review = Review.new
    movie_id = params[:movie_id]
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API_KEY']}&language=ja"
    @url_params = URI.parse(url)
    # 実際にアクセスしてデータを取得
    @api_datas  = Net::HTTP.get(@url_params)
    # JSONデータを連想配列で取得
    @movies_infos     = JSON.parse(@api_datas)
    # JSONデータのresults配列内を参照
    @movies_datas = @movies_infos['results']
  end
  
  
  
  private

  def review_params
    params.require(:review).permit(:title, :image, :overview, :review_title, :review_comment, :star)
  end

end
