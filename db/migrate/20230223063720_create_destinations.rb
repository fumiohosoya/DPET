class CreateDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :destinations do |t|
      t.bigint :company_id
      t.string :destination

      t.timestamps
    end
  end
end
