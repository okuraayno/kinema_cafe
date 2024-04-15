class CreateChecks < ActiveRecord::Migration[6.1]
  def change
    create_table :checks do |t|
      t.integer :user_id
      t.integer :movie_id
      t.boolean :check_status

      t.timestamps
    end
  end
end
