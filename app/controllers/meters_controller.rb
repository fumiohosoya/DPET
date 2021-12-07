class MetersController < ApplicationController
    
    before_action :require_driver_logged_in
    
    
    def new
      @meter = Meter.new
      @meter.checkimages.build
    end 
    
    def create
        
       @meter = Meter.new(meter_params)
       @meter.type = "Meter"
       if (@meter.save)
           flash[:success] = "Photo saved"
           redirect_to topmenu_url(@current_driver.id)
       else
           flash[:error] = "Photo not Saved, Please Set Again"
           render :new
       end
    end
    
    private
    
    def meter_params
       params.require(:meter).permit(:driver_id, checkimages_attributes:[:image])
    end
end
