class FueltargetsController < ApplicationController
    
    def new
        if params[:truck]
            @truck = Truck.find(params[:truck])
            @fueltarget = @truck.build_fueltarget
            @fueltarget.fuel = @fueltarget.default(@truck)
        else
            redirect_back(fallback_to: adminpane_url)
        end
    end
    
    
    def create
        @fueltarget = Fueltarget.new(ftarget_params)
        if (@fueltarget.save)
            flash[:success] = "Fuel target saved"
            redirect_to truckindex_admin_index_url
        else
            flash[:error] = "Fuel target can't save"
            @truck = @fueltarget.truck
            @fueltarget.fuel = @fueltarget.default(@truck)
            render :new
        end
    end
    
    def edit
        @fueltarget = Fueltarget.find(params[:id])
        @truck = @fueltarget.truck
    end
    
    def update
        @fueltarget = Fueltarget.find(params[:id])
        if (@fueltarget.update(ftarget_params))
            flash[:success] = "Fuel target saved"
            redirect_to truckindex_admin_index_url
        else
            flash[:error] = "Fuel target can't save"
            @fueltarget.fuel = @fueltarget.default(@truck)
            render :edit
        end
    end
    
    private
    
    def ftarget_params
        params.require(:fueltarget).permit(:truck_id, :fuel)
    end

end
