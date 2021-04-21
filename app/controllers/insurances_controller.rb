class InsurancesController < ApplicationController

    def new
       @vehicle_id = params[:vehicle_id]
       #@insurances = Insurances.all
       #@insurance = Insurance.new
    end
    
    
    def create

        @insurance = Insurance.new(params[:id])
        
        if (@insurance.save)
            
            flash[:success] = "Insurance fee updated"
        else
            flash[:error] = "Insurarance not updated"
        end        
        
    end
    
    def update
        @insurance = Insurance.find(params[:id])
        
        if (@insurance.update(insurance_params)) 
            flash[:success] = "Insurance fee updated"
        else
            flash[:error] = "Insurarance not updated"
        end
        
    end
    
private
    
    def insurance_params
        params.require(:insurance).permit(:name, :price)
        
    end
    
end
