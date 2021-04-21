class OthersController < ApplicationController
    def new
       @vehicle_id = params[:vehicle_id]
       @other = Other.new
    end
    
    def create
       
        @other = Other.new(other_params)
        if (@other.save)
            flash[:success] = "Other registered"
        else
            flash[:error] = "Other failed to registered"
        end
    end
    
    def update
    end
    
    private
    
    def other_params
        params.require(:other).permit(:vehicle_id, :date, :total_amount)
    end
end
