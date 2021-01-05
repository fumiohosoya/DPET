class VehicleSalesController < ApplicationController
 def index
     #render plain: 'ここがVehicle_sales入力画面です'
     
     @vehicle_sales = Vehicle_sale.all.order(:id).page(params[:page])
 end
 
 def show
  @vehicle_sales = Vehicle_sales.find(params[:id])
 end
 
 def new
   @vehicle_sale = VehicleSale.new
 end
 
 
 def create
  @vehicle_sales = Vehicle_sales.new(vehicle_sales_params)
   if (@vehicle_sales.save)
     redirect_to @vehicle_sales
   else
    flash[:error] = "Invalid Vehilce_sales Data"
    render :new
   end
 end
  
  
 def edit
   @vehicle_sales = Vehilce_sales.find(params[:id])
 end  
 
 def update
  
  # /vehilce_sales/1   method "PUT"
 @vehicle_sales = Vehicle_sales.find(params[:id])
   if @vehicle_sales.update(vehicle_sales_params)
    flash[:success] = 'Vehicle_sales Data was successfully updated'
    #render :edit
    redirect_to vehicle_sales_url(@vehicle_sales)
    
   else
    flash.now[:danger] = 'Update was not suucessful'
    render :edit
    #redirect_to vehicle_sales_url
   end
 end 
 
 def destroy
   @vehilce_sales = Vehicle_sales.find(params[:id])
    @vehicle_sales.destory if (@vehicle_sales)
    #redirect_to vehicle_sales_url
    render :destroy
 end
 
 
 
 
 
private
 
   
     
   def vehicle_sales_params
    params.require(:vehicle_sales).permit(:vehicle_id,
    :date, :maintenance, :insurance, :highway, :others,
    :fuel, :mileage, :fuel_consumption, :direct_labor_cost,
    :indirect_labor_cost, :special_cost, :other_cost,
    :sales_month, :profit_month)
   end
   
end
    
