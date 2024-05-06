class User::ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:new, :create, :edit, :update]
  before_action :set_movie, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :set_movie_genre_names, only: [:show, :new, :edit, :destroy]

  def show
    @review = Review.find(params[:id])
    @comment = Comment.new
    @average_score = Review.where(movie_id: @movie['id']).average(:star).to_f.round(1)
    @keywords = Language.get_data(@movie['overview'])
  end

  def new
    if Review.exists?(user_id: current_user.id, movie_id: @movie['id'])
      redirect_to edit_movie_review_path(@movie['id'], current_user.reviews.find_by(movie_id: @movie['id']).id)
    else
      @review = Review.new
    end
    @average_score = Review.where(movie_id: @movie['id']).average(:star).to_f.round(1)
    @keywords = Language.get_data(@movie['overview'])
  end

  def create
    if Review.exists?(user_id: current_user.id, movie_id: @movie['id'])
      redirect_to edit_movie_review_path(@movie['id'], current_user.reviews.find_by(movie_id: @movie['id']).id)
    else
      @review = Review.new(review_params)
      @review.user_id = current_user.id
      if @review.save
        flash[:notice] = "レビューを投稿しました。"
        redirect_to movie_path(@movie['id'])
      else
        flash[:notice] = "投稿内容を確認してください。"
        render "new"
      end
    end
  end

  def edit
    @review = Review.find(params[:id])
    @rating = @review.star
    @average_score = Review.where(movie_id: @movie['id']).average(:star).to_f.round(1)
    @keywords = Language.get_data(@movie['overview'])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:notice] = "レビューを編集しました。"
      redirect_to movie_path(@movie['id'])
    else
      @rating = @review.star
      flash[:notice] = "編集内容を確認してください。"
      render "edit"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to movie_path(@movie['id'])
  end

  private

  def set_movie
    @movie = Movie.fetch_movie_data(params[:movie_id])
  end

  def set_movie_genre_names
    @movie_genre_names = Movie.fetch_genre_names(params[:movie_id])
  end

  def is_matching_login_user
    @reviews = Review.find(params[:id])
    unless @reviews.user_id == current_user.id
      redirect_to movie_review_path, notice: "他ユーザーのレビュー編集画面には遷移できません。"
    end
  end
  
  def ensure_guest_user
    if current_user&.email == "guest@example.com"
      redirect_to user_path(current_user), notice: "ゲストユーザーはこの操作を行うことはできません。"
    end
  end

  def review_params
    params.require(:review).permit(:user_id, :movie_id, :title, :comment, :star, :spoiler, :tag)
  end

end