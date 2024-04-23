class User::UsersController < ApplicationController
  # 非ログイン時にアクセスするとログイン画面に遷移
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :set_movie, only: [:show]

  def index
    if params[:content].blank?  # 検索フォームが空の場合
      @users = User.all  # ユーザー全件を取得
    else
      @users = User.search_for(params[:content], params[:method])  # 検索結果を取得
    end
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.page(params[:page]).per(20)
    @favorites = @user.favorites
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
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
      redirect_to user_path, notice: "他ユーザーの編集画面には遷移できません。"
    end
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
  
end
