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
         flash[:success] = thai_trans("Photo saved")
         redirect_to topmenu_url(@current_driver.id)
       else
         flash[:error] =  thai_trans("Photo/Data not Saved, Please Set Again")

         unless (@battery.checkimages.any?)
             @battery.checkimages.build
         end
         render :new
       end
    end
    
    private
    
    def battery_params
       params.require(:battery).permit(:driver_id, checkimages_attributes:[:image])
    end
end
