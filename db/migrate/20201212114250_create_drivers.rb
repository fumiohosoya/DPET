class CreateDrivers < ActiveRecord::Migration[5.2]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :sex
      t.date :date_birth
      t.integer :age
      t.date :hire_date
      t.string :blood_type
      t.string :chronic_disease
      t.string :accident_record
      t.string :vioration_record

      t.timestamps
    end
  end
end
