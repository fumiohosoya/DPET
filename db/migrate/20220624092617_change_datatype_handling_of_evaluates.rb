class ChangeDatatypeHandlingOfEvaluates < ActiveRecord::Migration[5.2]
  def change
    
    add_column :evaluates, :handling, :datetime
    add_column :evaluates, :spover_time, :datetime
    add_column :evaluates, :idling, :datetime
    add_column :evaluates, :running, :datetime
    
    
  def up
    remove_column :evaluates, :handling, :datetime
    remove_column :evaluates, :spover_time, :datetime
    remove_column :evaluates, :idling, :datetime
    remove_column :evaluates, :running, :datetime
    
    add_column :evaluates, :handling, :datetime
    add_column :evaluates, :spover_time, :datetime
    add_column :evaluates, :idling, :datetime
    add_column :evaluates, :running, :datetime
  end

  def down
    remove_column :evaluates, :handling, :datetime
    remove_column :evaluates, :spover_time, :datetime
    remove_column :evaluates, :idling, :datetime
    remove_column :evaluates, :running, :datetime
    
    add_column :evaluates, :handling, :time
    add_column :evaluates, :spover_time, :time
    add_column :evaluates, :idling, :time
    add_column :evaluates, :running, :time
  end
  end
end
