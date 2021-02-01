class AddFuelCostToVehicleSales < ActiveRecord::Migration[5.2]
  def change
    add_column :vehicle_sales, :fuel_cost, :float
  end
end
