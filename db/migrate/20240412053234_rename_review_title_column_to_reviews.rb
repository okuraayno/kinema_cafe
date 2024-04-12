class RenameReviewTitleColumnToReviews < ActiveRecord::Migration[6.1]
  def change
    rename_column :reviews, :review_title, :ti
  end
end
