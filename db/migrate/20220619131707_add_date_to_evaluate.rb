class AddDateToEvaluate < ActiveRecord::Migration[5.2]
  def change
    add_column :evaluates, :recordmonth, :date
  end
end
