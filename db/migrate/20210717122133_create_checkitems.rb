class CreateCheckitems < ActiveRecord::Migration[5.2]
  def change
    create_table :checkitems do |t|
      t.string :type
      t.references :driver, foreign_key: true
      t.timestamps
    end
  end
end
