class DailyresultsController < ApplicationController
  
  include DriversHelper
  
  before_action :require_driver_logged_in
  
  def create
    dresults = current_driver.dailyresults.new(dailyresult_params) 
    dresults.save
    redirect_to  topmenu_url(@current_driver)
  end
  
  private
  
  def dailyresult_params
    params.require(:dailyresult).permit(:driver_id, :truck_id, :mileage, :fuel, :recorddate)
  end
end
