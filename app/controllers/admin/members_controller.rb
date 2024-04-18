class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    if params[:content].blank?
      @members = User.all
    else
      @members = User.search_for(params[:content], params[:method])  # 検索結果を取得
    end
  end

  def show
    @member = User.find(params[:id])
    @reviews = @member.reviews
  end
  
  def update
    @member =  User.find(params[:id])
    @member.update(user_params)
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:user_id, :is_active)
  end
  
end