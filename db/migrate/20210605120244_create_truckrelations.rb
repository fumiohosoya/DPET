class CreateTruckrelations < ActiveRecord::Migration[5.2]
  def change
    create_table :truckrelations do |t|
      t.references :truck, foreign_key: true
      t.references :driver, foreign_key: true

      t.timestamps
    end
  end
end
