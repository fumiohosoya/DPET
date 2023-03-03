class LampStopperTiresController < ApplicationController
    
    before_action :require_driver_logged_in
    
    
    def new
    @lampStopperTire = LampStopperTire.new
    @lampStopperTire1 =@lampStopperTire.checkimages.build
    @lampStopperTire.lamp = 0
    @lampStopperTire.stopper = 0
    @lampStopperTire.oilDrops = 0

    end 
    
    def create
#      binding.pry
      @lampStopperTire = LampStopperTire.new(lampStopperTire_params)
      @lampStopperTire.type = "LampStopperTire"
       if (@lampStopperTire.save)
           flash[:success] = "Photo saved"
           redirect_to topmenu_url(@current_driver.id)
       else
           
           #binding.pry
           #if (params[:lamp_stopper_tire][:checkimages_attributes].present?) 
           #    @lampStopperTire.checkimages.build(params[:lamp_stopper_tire][:checkimages_attributes])
           #end

           flash[:error] = "Photo/Data not Saved, Please Set Again"
           unless (@lampStopperTire.checkimages.any?)
            @lampStopperTire.checkimages.build
           end
           render :new
       end
    end
    
    private
    
    def lampStopperTire_params
       params.require(:lamp_stopper_tire).permit(:driver_id, :lamp, :stopper, :oilDrops, checkimages_attributes:[:id, :checkitem_id, :image, :image_cache])
    end

    
    
end
