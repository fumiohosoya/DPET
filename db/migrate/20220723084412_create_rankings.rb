class CreateRankings < ActiveRecord::Migration[5.2]
  def change
    create_table :rankings do |t|
      t.integer :company
      t.integer :A
      t.integer :B
      t.integer :C
      t.integer :D
      t.integer :E

      t.timestamps
    end
  end
end
