class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.text :tag
      t.integer :review_id
      t.integer :movie_id

      t.timestamps
    end
  end
end
