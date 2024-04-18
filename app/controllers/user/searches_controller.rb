class User::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @content = params[:content]
    @method = params[:method]
    @model == "user"
      @records = User.search_for(@content, @method)
  end
end
