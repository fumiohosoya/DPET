class BatteriesController < ApplicationController
    before_action :require_driver_logged_in
    
    
    def new
      @battery = Battery.new
      @battery.checkimages.build
    end 
    
    def create
        
       @battery = Battery.new(battery_params)
       @battery.type = "Battery"
       if (@battery.save)
           flash[:success] = "Photo saved"
           redirect_to topmenu_url(@current_driver.id)
       else
           flash[:error] = "Photo not Saved, Please Set Again"
           render :new
       end
    end
    
    private
    
    def battery_params
       params.require(:battery).permit(:driver_id, checkimages_attributes:[:image])
    end
end
