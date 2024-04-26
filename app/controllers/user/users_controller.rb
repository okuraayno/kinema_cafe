class User::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  before_action :set_movie, only: [:show]

  def index
    if params[:content].blank?  # 検索フォームが空の場合
      @users = User.all  # ユーザー全件を取得
    else
      @users = User.search_for(params[:content], params[:method])  # 検索結果を取得
    end

    @users = @users.where.not(email: 'guest@example.com') # ゲストユーザーは非表示
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.page(params[:page]).per(10)
  end
  
  def favorites 
    @user = User.find(params[:user_id])
    @favorites = @user.favorites.page(params[:page]).per(10)
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "更新内容が保存されました"
      redirect_to user_path(@user)
    else
      flash[:notice] = "更新に失敗しました"
      render :edit
    end
  end

  def withdraw
    @user = current_user
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行しました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :is_active)
  end

  def set_movie
    @movie = Movie.fetch_movie_data(params[:movie_id])
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path, notice: "他ユーザーのプロフィール編集画面には遷移できません。"
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end
