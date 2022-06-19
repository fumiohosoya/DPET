class CreateExtCheckMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :ext_check_menus do |t|
      t.date :record_date
      t.string :type
      t.string :name
      t.integer :company_id
      t.string :description
      t.string :image_url

      t.timestamps
    end
  end
end
