class GreaseupsController < ApplicationController
    
    
    before_action :require_driver_logged_in
    
    
    def new
   @greaseup = Greaseup.new
   @greaseup1 =@greaseup.checkimages.build

    end 
    
    def create
#      binding.pry
     @greaseup = Greaseup.new(tire_params)
     @greaseup.type = "Greaseup"
       if (@greaseup.save)
           flash[:success] = thai_trans("Photo saved")
           redirect_to topmenu_url(@current_driver.id)
       else
           flash[:error] = "Photo/Data not Saved, Please Set Again"
           unless (@greaseup.checkimages.any?)
               @greaseup.checkimages.build
           end
           render :new
       end
    end
    
    private
    
    def tire_params
       params.require(:greaseup).permit(:driver_id, checkimages_attributes:[:id, :checkitem_id, :image])
    end
    
end