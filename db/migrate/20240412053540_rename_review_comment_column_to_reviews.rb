class RenameReviewCommentColumnToReviews < ActiveRecord::Migration[6.1]
  def change
    rename_column :reviews, :review_comment, :comment
  end
end
