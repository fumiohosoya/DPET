class AddEmailToDriver < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers, :email, :string
    add_column :drivers, :password_digest, :string
  end
end
