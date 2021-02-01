class AddFuelPriceToVehicleSales < ActiveRecord::Migration[5.2]
  def change
    add_column :vehicle_sales, :fuel_price, :float
  end
end
