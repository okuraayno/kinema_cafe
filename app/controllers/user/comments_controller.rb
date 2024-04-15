class User::CommentsController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    @comment = current_user.comments.new(comment_params)
    @comment.review_id = @review.id
    @comment.save
  end

  def destroy
    Comment.find(params[:id]).destroy
  end

private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
