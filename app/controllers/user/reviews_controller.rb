class User::ReviewsController < ApplicationController

# set_movie呼び出し
  before_action :set_movie, only: [:show, :new, :create, :edit, :update]

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
  end

  def create
    review = Review.new(review_params)
    review.user_id = current_user.id
    if review.save
      redirect_to movie_path(@movie['id']), notice: "You have created book successfully."
    else
      render 'new'
    end
  end
  
  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to movie_path(@movie['id']), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to movies_path
  end

  private

  def set_movie
    @movie = Movie.fetch_movie_data(params[:movie_id])
  end

  def review_params
    params.require(:review).permit(:user_id, :movie_id, :title, :comment, :star)
  end

end