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
           flash[:success] = thai_trans("Photo saved")
           redirect_to topmenu_url(@current_driver.id)
       else
           flash[:error] =  thai_trans("Photo/Data not Saved, Please Set Again")

           unless (@brake.checkimages.any?)
               @brake.checkimages.build
           end
           render :new
       end
    end
    
    private
    
    def brake_params
       params.require(:brake).permit(:driver_id, checkimages_attributes:[:image, :image_cache])
    end
    
end
