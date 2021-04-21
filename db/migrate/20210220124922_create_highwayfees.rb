class CreateHighwayfees < ActiveRecord::Migration[5.2]
  def change
    create_table :highwayfees do |t|
      t.integer :vehicle_id
      t.date :date
      t.integer :price

      t.timestamps
    end
  end
end
