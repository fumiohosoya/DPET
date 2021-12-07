class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name_j
      t.string :name_e
      t.boolean :opt_tirerotation

      t.timestamps
    end
  end
end
