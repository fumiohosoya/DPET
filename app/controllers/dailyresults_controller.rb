class DailyresultsController < ApplicationController
  
  include DriversHelper
  
  before_action :require_driver_logged_in
  
  def create
    dresults = current_driver.dailyresults.new(dailyresult_params)
    dr = Dailyresult.where(truck_id: dresults.truck_id)
    thash = gettruck_by_id(dresults.truck_id)
    if (dr.any? && dr.last.mileage <=  dresults.mileage)
      dresults.save
      redirect_to  topmenu_url(@current_driver)
    elsif (thash["initmileage"] <= dresults.mileage.to_i )
      dresults.save
      redirect_to  topmenu_url(@current_driver)
    else
      flash[:now] = "Value under previous or initialize, should be over #{thash['initmileage']}" 
      redirect_to  topmenu_url(@current_driver)
    end
  end
  
  private
  
  def dailyresult_params
    params.require(:dailyresult).
      permit(:driver_id, :truck_id, :mileage, :fuel, :recorddate, :destination)
  end
end
