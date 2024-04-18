class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_movie, only: [:index, :show]

  def index
    if params[:content].blank?
      @reviews = Review.all
    else
      @reviews = Review.search_for(params[:content], params[:method])  # 検索結果を取得
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to admin_reviews_path

  end

  def set_movie
    @movie = Movie.fetch_movie_data(params[:movie_id])
  end

end
