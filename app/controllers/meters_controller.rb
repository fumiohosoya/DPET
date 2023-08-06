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
           flash[:success] = thai_trans("Photo saved")
           redirect_to topmenu_url(@current_driver.id)
       else
           flash[:error] =  thai_trans("Photo/Data not Saved, Please Set Again")

           @meter.checkimages.build
           render :new
       end
    end
    
    private
    
    def meter_params
       params.require(:meter).permit(:driver_id, checkimages_attributes:[:image, :image_cache])
    end
end
