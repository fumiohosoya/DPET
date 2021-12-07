class BrakesController < ApplicationController
    
    before_action :require_driver_logged_in
    
    
    def new
      @brake = Brake.new
      @brake1 = @brake.checkimages.build

    end 
    
    def create
        
       @brake = Brake.new(brake_params)
       @brake.type = "Brake"
       if (@brake.save)
           flash[:success] = "Photo saved"
           redirect_to topmenu_url(@current_driver.id)
       else
           flash[:error] = "Photo not Saved, Please Set Again"
           render :new
       end
    end
    
    private
    
    def brake_params
       params.require(:brake).permit(:driver_id, checkimages_attributes:[:image])
    end
    
end
