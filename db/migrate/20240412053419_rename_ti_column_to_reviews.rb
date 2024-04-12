class RenameTiColumnToReviews < ActiveRecord::Migration[6.1]
  def change
    rename_column :reviews, :ti, :title
  end
end
