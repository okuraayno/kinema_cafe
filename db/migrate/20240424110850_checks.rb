class Checks < ActiveRecord::Migration[6.1]
  def change
    drop_table :checks
  end
end
