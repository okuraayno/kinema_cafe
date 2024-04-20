class RemoveTagFromReviews < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :tag, :string
  end
end
