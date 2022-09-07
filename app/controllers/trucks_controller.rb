class TrucksController < ApplicationController
   include DriversHelper
 
 def maketruck_model(tinfo)
    truck = Truck.new()
    truck.id = tinfo["id"]
    truck.company_id = tinfo["company_id"]
    truck.branch_id  = tinfo["branch_id"]
    truck.maker = tinfo["maker"]
    truck.model = tinfo["model"]
    truck.body = tinfo["body"]
    truck.wheels = tinfo["wheels"]
    truck.year = tinfo["year"]
    truck.age = tinfo["age"]
    truck.engine = tinfo["engine"]
    truck.vehicleid = tinfo["vehicleid"]
    truck.number = tinfo["number"]
    truck.e_oil = tinfo["e_oil"]
    truck.tm_oil = tinfo["tm_oil"]
    truck.tire = tinfo["tire"]
    truck.df_oil = tinfo["df_oil"]
    truck.initmileage = tinfo["initmileage"]
    truck.purchase = tinfo["purpurchase"]
    truck.image_url = tinfo["image"]["url"]
    truck.thumb_url = tinfo["image"]["thumb"]["url"]
    truck.created_at = tinfo["created_at"]
    return truck
 end
 
  def new
    @truck = Truck.new()
  end
  
  def create
      number = params[:trucknumber]
  
    @truck = Truck.find_or_initialize_by(number: number)

    if (@truck.new_record?)
      flash[:error] = "Truck newly regitered"
      tinfo = gettruck(number)
      @truck = maketruck_model(tinfo)
      @truck.save
     else
       flash[:error] = "Truck already regitered"
     end
     redirect_to truckindex_admin_index_url
  end

  def destroy
  end
  
  private
  
  def truck_params
    params.require(:truck).permit(:company_id, :branch_id)
  end
 
end
