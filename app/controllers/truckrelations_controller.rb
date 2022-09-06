class TruckrelationsController < ApplicationController
  def create
    @t_relation = Truckrelation.find_or_create_by(truckrelation_params)
    redirect_back(fallback_location: root_url)
  end

  def destroy
    t_relation = Truckrelation.find(params[:id])
    t_relation.destroy if t_relation
    redirect_back(fallback_location: root_url)
  end
  
  
  private
  
  def truckrelation_params
    params.require(:truckrelation).permit(:driver_id, :truck_id)
  end
end
