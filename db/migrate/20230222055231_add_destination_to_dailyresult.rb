class AddDestinationToDailyresult < ActiveRecord::Migration[5.2]
  def change
    add_column :dailyresults, :destination, :string
  end
end
