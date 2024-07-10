class AddTitleToNews < ActiveRecord::Migration[6.1]
  def change
    add_column :news, :title, :string
  end
end
