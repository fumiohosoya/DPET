class HighwayController < ApplicationController
    def new
       @vehicle_id = params[:vehicle_id]
    end
end
