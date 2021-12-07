class AddCompanyToDriver < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers, :company, :string
    add_column :drivers, :branch, :string
  end
end
