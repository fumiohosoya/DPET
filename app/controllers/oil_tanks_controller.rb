class OilTanksController < ApplicationController
    
    before_action :require_driver_logged_in
    
    
    def new
       @oilTank = OilTank.new
       @oilTank1 =@oilTank.checkimages.build

    end 
    
    def create
#      binding.pry
        @oilTank = OilTank.new(tire_params)
        @oilTank.type = "OilTank"
        if (@oilTank.save)
           flash[:success] = thai_trans("Photo saved")
           redirect_to topmenu_url(@current_driver.id)
        else
           
           #binding.pry
           #if (params[:lamp_stopper_tire][:checkimages_attributes].present?) 
           #   @oilTank.checkimages.build(params[:lamp_stopper_tire][:checkimages_attributes])
           #end
        
           flash[:error] = thai_trans("Photo/Data not Saved, Please Set Again")
           #unless (@oilTank.checkimages.any? && @oilTank.checkimages.count > 1)
           unless (@oilTank.checkimages.any?)
               @oilTank.checkimages.build
           end
           render :new
        end
    end
    
    private
    
    def tire_params
       params.require(:oil_tank).permit(:driver_id, checkimages_attributes:[:id, :checkitem_id, :image, :image_cache])
    end
    
end
