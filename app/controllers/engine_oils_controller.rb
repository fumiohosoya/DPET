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
           flash[:success] = "Photo saved"
           redirect_to topmenu_url(@current_driver.id)
       else
           flash[:error] = "Photo not Saved, Please Set Again"
           render :new
       end
    end
    
    private
    
    def engineoil_params
       params.require(:engine_oil).permit(:driver_id, checkimages_attributes:[:image])
    end
end