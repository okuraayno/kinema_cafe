class ChangeDataStarToReview < ActiveRecord::Migration[6.1]
  def change
    change_column :reviews, :star, :float
  end
end
