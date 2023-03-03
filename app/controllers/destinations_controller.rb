class DestinationsController < ApplicationController
    
    def index
      @companies = allcompanies_model
      @branches = @companies.map {|c|  branches_by_cid_model(c.id.to_s)[0] }
      if (params[:company])
       @target_c = array_find_by(@companies, params[:company])
      else
       @target_c = @companies.first
      end
      @destinations =  Destination.where(company_id: @target_c.id).page(params[:page])
      @destination = Destination.new
    end
    
    
    def create
        @companies = allcompanies_model
        #@branches = @companies.map {|c|  branches_by_cid_model(c.id.to_s)[0] }
        
        @destination = Destination.new(destination_params)
        @target_c = array_find_by(@companies, @destination.company_id)
        
        @destinations =  Destination.where(company_id: @target_c.id).order(:company_id).page(params[:page])
        if (@destination.save)
            flash[:now] = "Destination Registered"
            redirect_to destinations_path(company: @target_c.id)
        else
            flash[:now] = "Destination Failed"
            render :index    # index use @target_c as compnany target
        end
            
        
    end
    
    def destroy
        @destination = Destination.find(params[:id])
        company_id = @destination.company_id
        @destination.destroy
        redirect_to destinations_path(company: company_id)
    end
    
    private
    
    def destination_params
        params.require(:destination).permit(:company_id, :destination)
    end
end
