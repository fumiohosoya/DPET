class CreateDailyresults < ActiveRecord::Migration[5.2]
  def change
    create_table :dailyresults do |t|
      t.references :driver, foreign_key: true
      t.integer :truck_id
      t.float :mileage
      t.float :fuel
      t.date :recorddate

      t.timestamps
    end
  end
end
