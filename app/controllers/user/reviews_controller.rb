class User::ReviewsController < ApplicationController

# set_movie呼び出し
  before_action :set_movie, only: [:show, :new, :create, :edit, :update, :destroy]

  def show
    @review = Review.find(params[:id])
    @comment = Comment.new
  end

  def new
    if Review.exists?(user_id: current_user.id, movie_id: @movie['id'])
      redirect_to edit_movie_review_path(@movie['id'], current_user.reviews.find_by(movie_id: @movie['id']).id)
    else
      @review = Review.new
    end
  end

  def create
    if Review.exists?(user_id: current_user.id, movie_id: @movie['id'])
      redirect_to edit_movie_review_path(@movie['id'], current_user.reviews.find_by(movie_id: @movie['id']).id)
    else
      review = Review.new(review_params)
      review.user_id = current_user.id
      if review.save
        redirect_to movie_path(@movie['id'])
      else
        render 'new'
      end
    end
  end
  
  def edit
    @review = Review.find(params[:id])
    @rating = @review.star
  end

  # ローカル変数にする
  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to movie_path(@movie['id'])
    else
      render "edit" 
    end
  end
  
  # ローカル変数にする
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to movie_path(@movie['id'])
  end

  private

  def set_movie
    @movie = Movie.fetch_movie_data(params[:movie_id])
  end

  def review_params
    params.require(:review).permit(:user_id, :movie_id, :title, :comment, :star, :spoiler)
  end

end