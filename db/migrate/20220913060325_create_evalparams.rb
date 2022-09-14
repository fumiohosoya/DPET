class CreateEvalparams < ActiveRecord::Migration[5.2]
  def change
    create_table :evalparams do |t|
      t.integer :company_id
      t.integer :fuelA
      t.integer :fuelB
      t.integer :fuelC
      t.integer :fuelD
      t.integer :fuelE
      t.integer :fuelF
      t.float :balanceSafety
      t.float :balanceCheck
      t.float :balanceFuel

      t.timestamps
    end
  end
end
