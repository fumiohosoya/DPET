class CreateHighways < ActiveRecord::Migration[5.2]
  def change
    create_table :highways do |t|
      t.integer :vehicle_id
      t.date :date
      t.integer :total_amount

      t.timestamps
    end
  end
end
