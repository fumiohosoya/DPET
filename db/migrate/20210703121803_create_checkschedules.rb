class CreateCheckschedules < ActiveRecord::Migration[5.2]
  def change
    create_table :checkschedules do |t|
      t.integer :dayofweek
      t.references :checkmenu, foreign_key: true
      t.integer :company_id

      t.timestamps
    end
  end
end
