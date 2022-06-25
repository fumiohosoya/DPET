class CreateEvaluates < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluates do |t|
      t.string :type
      t.references :driver, foreign_key: true
      t.integer :op_count
      t.integer :empty_conv
      t.integer :occupied_conv
      t.integer :mileage
      t.datetime :handling
      t.integer :speedover
      t.datetime :spover_time
      t.integer :scramble
      t.integer :rapid_accel
      t.integer :abrupt_decel
      t.datetime :idling
      t.datetime :running
      t.float :evaluate
      t.string :rank
      t.date :recordmonth

      t.timestamps
    end
  end
end
