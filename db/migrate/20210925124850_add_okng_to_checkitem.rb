class AddOkngToCheckitem < ActiveRecord::Migration[5.2]
  def change
    add_column :checkitems, :lamp, :boolean
    add_column :checkitems, :stopper, :boolean
    add_column :checkitems, :oilDrops, :boolean
  end
end
