class EvalparamsController < ApplicationController
    
    def index
     @companies = allcompanies_model
     @branches = @companies.map {|c|  branches_by_cid_model(c.id.to_s)[0] }
     if (params[:company])
      @target_c = array_find_by(@companies, params[:company])
     else
      @target_c = @companies.first
     end
     @evalparam = Evalparam.find_by(company_id: @target_c.id)
     if (@evalparam == nil)
        @evalparam = Evalparam.new({
            company_id: @target_c.id,
            fuelA: 110, fuelB: 100, fuelC: 90, fuelD: 80, fuelE: 70, fuelF: 60,
            balanceSafety: 33.30,
            balanceCheck:  33.40,
            balanceFuel: 33.30
        })
        @balanceSafety = 33.30
        @balanceCheck = 33.40
        @balanceFuel = 33.40
     else
        @balanceSafety = @evalparam.balanceSafety
        @balanceCheck = @evalparam.balanceCheck
        @balanceFuel = @evalparam.balanceFuel
     end
    end
    
    
    def create
        @evalparam = Evalparam.new(evalparam_params)
        if (@evalparam.save)
            flash[:success] = "Parameters are saved"
            redirect_to evalparams_url(company: @evalparam.company_id)
        else
            flash[:success] = "Parameters are not saved"
            redirect_to evalparams_url(company: @evalparam.company_id)
        end
    end
    
    
    private
    
    def evalparam_params
        params.require(:evalparam)
            .permit(:company_id, :fuelA, :fuelB, :fuelC, :fuelD, :fuelE, :fuelF,
                    :balanceSafety, :balanceCheck, :balanceFuel)
    end
end
