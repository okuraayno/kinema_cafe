class Admin::MembersController < ApplicationController
  
  def index
    if params[:looking_for].present?
      @members = User.where("name LIKE ?", "%#{params[:looking_for]}%")
    else
      @members = User.all
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