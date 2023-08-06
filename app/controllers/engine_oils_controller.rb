class EngineOilsController < ApplicationController
    
    
    before_action :require_driver_logged_in
    
    
    def new
      @engineoil = EngineOil.new
      @engineoil.checkimages.build
    end 
    
    def create
        
       @engineoil = EngineOil.new(engineoil_params)
       @engineoil.type = "EngineOil"
       if (@engineoil.save)
           flash[:success] = thai_trans("Photo saved")
           redirect_to topmenu_url(@current_driver.id)
       else
           flash[:error] =  thai_trans("Photo/Data not Saved, Please Set Again")

           unless (@engineoil.checkimages.any?)
               @engineoil.checkimages.build
           end
           render :new
       end
    end
    
    private
    
    def engineoil_params
       params.require(:engine_oil).permit(:driver_id, checkimages_attributes:[:image, :image_cache])
    end
end
