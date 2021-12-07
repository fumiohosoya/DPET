class CreateCheckimages < ActiveRecord::Migration[5.2]
  def change
    create_table :checkimages do |t|
      t.string :image
      t.references :checkitem, foreign_key: true

      t.timestamps
    end
  end
end
