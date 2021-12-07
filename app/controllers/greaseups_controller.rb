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
           flash[:success] = "Photo saved"
           redirect_to topmenu_url(@current_driver.id)
       else
           
           #binding.pry
           #if (params[:lamp_stopper_tire][:checkimages_attributes].present?) 
           #   @greaseup.checkimages.build(params[:lamp_stopper_tire][:checkimages_attributes])
           #end

           flash[:error] = "Photo/Data not Saved, Please Set Again"
           render :new
       end
    end
    
    private
    
    def tire_params
       params.require(:greaseup).permit(:driver_id, checkimages_attributes:[:id, :checkitem_id, :image])
    end
    
end