class CreateReviewComments < ActiveRecord::Migration[6.1]
  def change
    create_table :review_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :review_id

      t.timestamps
    end
  end
end
