class CreateInsurances < ActiveRecord::Migration[5.2]
  def change
    create_table :insurances do |t|
      t.string :name
      t.integer :price
      t.integer :vehicle_id

      t.timestamps
    end
  end
end
