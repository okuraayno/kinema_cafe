class Admin::ReviewsController < ApplicationController

# set_movie呼び出し
  before_action :set_movie, only: [:index, :show]

  def index
    if params[:looking_for].present?
      @reviews = Review.where("name LIKE ?", "%#{params[:looking_for]}%")
    else
      @reviews = Review.all
    end
  end

  def show
    @review = Review.find(params[:id])
  end


  def set_movie
    @movie = Movie.fetch_movie_data(params[:movie_id])
  end

end
