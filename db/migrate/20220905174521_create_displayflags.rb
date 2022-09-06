class CreateDisplayflags < ActiveRecord::Migration[5.2]
  def change
    create_table :displayflags do |t|
      t.integer :company_id
      t.boolean :driverfuel

      t.timestamps
    end
  end
end
