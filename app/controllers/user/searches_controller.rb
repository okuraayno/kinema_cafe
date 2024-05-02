class User::SearchesController < ApplicationController
  # 非ログイン時にアクセスするとログイン画面に遷移
  before_action :authenticate_user!

  def search
    @content = params[:content]
    @method = params[:method]
    @model = "user"
      @records = User.search_for(@content, @method)
  end
end
