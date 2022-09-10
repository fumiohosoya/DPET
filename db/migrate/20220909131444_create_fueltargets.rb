class CreateFueltargets < ActiveRecord::Migration[5.2]
  def change
    create_table :fueltargets do |t|
      t.references :truck, foreign_key: true
      t.float :fuel

      t.timestamps
    end
  end
end
