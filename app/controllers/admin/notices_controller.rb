class Admin::NoticesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @notices = Notice.all
  end

  def show
    @notice = Notice.find(params[:id])
  end

  def new
    @notice = Notice.new
  end

  def create
    @notice = Notice.new(notices_params)
    if @notice.save
      flash[:notice] = "お知らせを投稿しました。"
      redirect_to notices_path
    else
      flash[:notice] = "投稿内容を確認してください。"
      render "new"
    end
  end
  
  private

  def news_params
    params.require(:notices).permit(:title , :text, :created_at)
  end
  
end
