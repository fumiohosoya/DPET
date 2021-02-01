class AddTotalCostToVehicleSales < ActiveRecord::Migration[5.2]
  def change
    add_column :vehicle_sales, :total_cost, :float
  end
end
