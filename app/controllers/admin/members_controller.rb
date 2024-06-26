class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    if params[:content].blank?
      @members = User.all
    else
      @members = User.search_for(params[:content], params[:method])
    end
    @members = Kaminari.paginate_array(@members).page(params[:page]).per(10)
  end

  def show
    @member = User.find(params[:id])
    @reviews = Kaminari.paginate_array(@member.reviews).page(params[:page]).per(10)
  end
  
  def update
    @member =  User.find(params[:id])
    @member.update(user_params)
    flash[:notice] = "会員ステータスを変更しました"
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:user_id, :is_active)
  end
  
end