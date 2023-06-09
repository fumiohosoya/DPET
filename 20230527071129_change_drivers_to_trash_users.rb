class ChangeDriversToTrashUsers < ActiveRecord::Migration[5.2]
  def change
    rename_table :drivers, :users
  end
end
