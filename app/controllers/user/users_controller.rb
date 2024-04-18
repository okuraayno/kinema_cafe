class User::UsersController < ApplicationController

  before_action :set_movie, only: [:show]

  def index
    if params[:looking_for].present?
      @users = User.where("name LIKE ?", "%#{params[:looking_for]}%")
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @favorites = @user.favorites
  end
  
  def edit
    is_matching_login_user
    @user = User.find(params[:id])
  end

  def update
    is_matching_login_user
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def set_movie
    @movie = Movie.fetch_movie_data(params[:movie_id])
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
  
end
