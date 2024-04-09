class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :image
      t.text :overview
      t.string :review_title
      t.text :review_comment
      t.string :star

      t.timestamps
    end
  end
end
