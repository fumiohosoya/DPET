class CreateTrucks < ActiveRecord::Migration[5.2]
  def change
    create_table :trucks do |t|
      t.integer :company_id
      t.integer :branch_id
      t.string :maker
      t.string :model
      t.string :body
      t.integer :wheels
      t.string :year
      t.string :age
      t.string :engine
      t.string :vehicleid
      t.string :number
      t.integer :e_oil
      t.integer :tm_oil
      t.string :tire
      t.integer :df_oil
      t.string :initmileage
      t.string :purchase
      t.string :image_url
      t.string :thumb_url

      t.timestamps
    end
  end
end
