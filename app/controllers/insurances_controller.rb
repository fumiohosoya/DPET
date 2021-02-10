class InsurancesController < ApplicationController

    def new
       @vehicle_id = params[:vehicle_id]
       #@insurances = Insurances.all
       #@insurance = Insurance.new
    end
end
