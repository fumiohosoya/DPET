class AirReserversController < ApplicationController
    
    before_action :require_driver_logged_in
    
    
    def new
     @airreserver =AirReserver.new
     @airreserver.checkimages.build
    end 
    
    def create
        
      @airreserver =AirReserver.new(airreserver_params)
      @airreserver.type = "AirReserver"
       if (@airreserver.save)
           flash[:success] = "Photo saved"
           redirect_to topmenu_url(@current_driver.id)
       else
           flash[:error] = "Photo not Saved, Please Set Again"
           render :new
       end
    end
    
    private
    
    def airreserver_params
       params.require(:air_reserver).permit(:driver_id, checkimages_attributes:[:image])
    end
end
