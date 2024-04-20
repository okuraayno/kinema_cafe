class User::ReviewsController < ApplicationController

  before_action :set_movie, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :set_movie_genre_names, only: [:show, :new, :edit, :destroy]

  def show
    @review = Review.find(params[:id])
    @comment = Comment.new
    @average_score = Review.where(movie_id: @movie['id']).average(:star).to_f.round(1)  

  end

  def new
    if Review.exists?(user_id: current_user.id, movie_id: @movie['id'])
      redirect_to edit_movie_review_path(@movie['id'], current_user.reviews.find_by(movie_id: @movie['id']).id)
    else
      @review = Review.new
    end
    @average_score = Review.where(movie_id: @movie['id']).average(:star).to_f.round(1)
  end

  def create
    if Review.exists?(user_id: current_user.id, movie_id: @movie['id'])
      redirect_to edit_movie_review_path(@movie['id'], current_user.reviews.find_by(movie_id: @movie['id']).id)
    else
      review = Review.new(review_params)
      review.user_id = current_user.id
      if review.save
        flash[:notice] = "You have created review successfully."
        redirect_to movie_path(@movie['id'])
      else
        render 'new'
      end
    end
  end

  def edit
    @review = Review.find(params[:id])
    @rating = @review.star
    @average_score = Review.where(movie_id: @movie['id']).average(:star).to_f.round(1)
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

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to movie_path(@movie['id'])
  end

  private

# 特定の映画データを取得
  def set_movie
    @movie = Movie.fetch_movie_data(params[:movie_id])
  end

  def set_movie_genre_names
    @movie_genre_names = Movie.fetch_genre_names(params[:movie_id])
  end

  def review_params
    params.require(:review).permit(:user_id, :movie_id, :title, :comment, :star, :spoiler, :tag)
  end

end