class ChangeNewsToTrashNotices < ActiveRecord::Migration[6.1]
  def change
    rename_table :news, :notices
  end
end
