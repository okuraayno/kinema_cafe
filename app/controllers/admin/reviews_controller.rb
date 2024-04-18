class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_movie, only: [:index, :show]

  def index
    if params[:looking_for].present?
      @reviews = Review.where("comment LIKE ?", "%#{params[:looking_for]}%")
    else
      @reviews = Review.all
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to admin_member_path(@user)

  end

  def set_movie
    @movie = Movie.fetch_movie_data(params[:movie_id])
  end

end
