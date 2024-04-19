class RenameTagColumnToReviews < ActiveRecord::Migration[6.1]
  def change
    rename_column :reviews, :tag, :tag1
  end
end
