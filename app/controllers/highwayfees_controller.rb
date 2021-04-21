class HighwayfeesController < ApplicationController
    def new
       @vehicle_id = params[:vehicle_id]
    end
    
    def create
        
        @highway = Highwayfee.new(highwayfee_params)
        
        if (@highway.save)
            flash[:success] = "Highway Fee registered"
        else
            flash[:error] = "Highway Fee Not registered"
        end
    end
    
    def update
    end
    
    
    private
    
    def highwayfee_params
        params.require(:highwayfee).permit(:date, :price, :vehicle_id)
    end
end


