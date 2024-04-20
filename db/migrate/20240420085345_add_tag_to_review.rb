class AddTagToReview < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :tag, :string
  end
end
