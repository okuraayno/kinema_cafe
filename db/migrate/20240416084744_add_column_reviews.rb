class AddColumnReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :spoiler, :boolean, null: false, default: false
  end
end
