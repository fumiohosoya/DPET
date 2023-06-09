class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.bigint :company_id
      t.bigint :branch_id
      t.bigint :truck_id
      t.references :driver, foreign_key: true
      t.string :title
      t.text :content
      t.string :image
      t.date :checkdate
      t.string :checkperson
      t.timestamps
    end
  end
end
