class CreateVehicleSales < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicle_sales do |t|
      t.integer :vehicle_id
      t.date :date
      t.integer :maintenance
      t.integer :insurance
      t.integer :highway
      t.integer :others
      t.float :fuel
      t.float :mileage
      t.float :fuel_consumption
      t.integer :direct_labor_cost
      t.integer :indirect_labor_cost
      t.integer :special_cost
      t.integer :other_cost
      t.float :sales_month
      t.float :profit_month

      t.timestamps
    end
  end
end
