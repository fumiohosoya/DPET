class TiresController < ApplicationController
    
    before_action :require_driver_logged_in
    
    
    def new
   @tire = Tire.new
   @tire1 =@tire.checkimages.build

    end 
    
    def create
#      binding.pry
     @tire = Tire.new(tire_params)
     @tire.type = "Tire"
       if (@tire.save)
           flash[:success] = thai_trans("Photo saved")
           redirect_to topmenu_url(@current_driver.id)
       else
           flash[:error] = thai_trans("Photo/Data not Saved, Please Set Again")
           unless (@tire.checkimages.any?)
               @tire.checkimages.build
           end
           render :new
       end
    end
    
    private
    
    def tire_params
       params.require(:tire).permit(:driver_id, checkimages_attributes:[:id, :checkitem_id, :image, :image_cache])
    end
    
end
