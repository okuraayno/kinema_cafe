class Admin::CommentsController < ApplicationController

  def destroy
    @review = Review.find(params[:review_id])
    Comment.find(params[:id]).destroy
  end

end
