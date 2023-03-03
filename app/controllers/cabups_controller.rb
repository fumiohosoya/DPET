class CabupsController < ApplicationController
    
    before_action :require_driver_logged_in
    
    
    def new
      @cabup = Cabup.new
      @cabup.checkimages.build
    end 
    
    def create
        
       @cabup = Cabup.new(cabup_params)
       @cabup.type = "Cabup"
       if (@cabup.save)
           flash[:success] = "Photo saved"
           redirect_to topmenu_url(@current_driver.id)
       else
           flash[:error] = "Photo not Saved, Please Set Again"
           unless (@cabup.checkimages.any?)
               @cabup.checkimages.build
           end
           render :new
       end
    end
    
    private
    
    def cabup_params
       params.require(:cabup).permit(:driver_id, checkimages_attributes:[:image, image_cache])
    end
end

