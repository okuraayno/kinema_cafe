class AddTag2ToReview < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :tag2, :string
  end
end
