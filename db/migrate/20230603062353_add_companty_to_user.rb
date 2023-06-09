class AddCompantyToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :company, :string
    add_column :users, :branch, :string
  end
end
