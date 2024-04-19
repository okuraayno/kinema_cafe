class AddTag3ToReview < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :tag3, :string
  end
end
