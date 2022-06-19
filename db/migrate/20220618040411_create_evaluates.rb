class CreateEvaluates < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluates do |t|
      t.string :type
      t.references :driver, foreign_key: true
      t.integer :op_count
      t.integer :empty_conv
      t.integer :occupied_conv
      t.integer :mileage
      t.time :handling
      t.integer :speedover
      t.time :spover_time
      t.integer :scramble
      t.integer :rapid_accel
      t.integer :abrupt_decel
      t.time :idling
      t.time :running
      t.float :evaluate
      t.string :rank

      t.timestamps
    end
  end
end
