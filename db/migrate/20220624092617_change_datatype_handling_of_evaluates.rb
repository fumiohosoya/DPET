class ChangeDatatypeHandlingOfEvaluates < ActiveRecord::Migration[5.2]
  def change
    
    change_column :evaluates, :handling, :datetime
    change_column :evaluates, :spover_time, :datetime
    change_column :evaluates, :idling, :datetime
    change_column :evaluates, :running, :datetime
  end
end
