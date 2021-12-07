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
           flash[:success] = "Photo saved"
           redirect_to topmenu_url(@current_driver.id)
       else
           
           #binding.pry
           #if (params[:lamp_stopper_tire][:checkimages_attributes].present?) 
           #   @tire.checkimages.build(params[:lamp_stopper_tire][:checkimages_attributes])
           #end

           flash[:error] = "Photo/Data not Saved, Please Set Again"
           render :new
       end
    end
    
    private
    
    def tire_params
       params.require(:tire).permit(:driver_id, checkimages_attributes:[:id, :checkitem_id, :image])
    end
    
end
