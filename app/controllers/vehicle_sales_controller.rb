class VehicleSalesController < ApplicationController
 def index
     #render plain: 'ここがVehicle_sales入力画面です'
     
     @vehicle_sales = VehicleSale.all.order(:id).page(params[:page])
 end
 
 def show
   @vehicle_sale= VehicleSale.find(params[:id])
 end
 
 def new
   @vehicle_sale = VehicleSale.new
 end
 
 
 def create
  @vehicle_sale = VehicleSale.new(vehicle_sales_params)
   if (@vehicle_sale.save)
     redirect_to @vehicle_sale
   else
    flash[:error] = "Invalid Vehilce_sales Data"
    render :new
   end
 end
  
  
 def edit
   @vehicle_sale = VehicleSale.find(params[:id])
 end  
 
 def update
  
  # /vehilce_sales/1   method "PUT"
 @vehicle_sale = VehicleSale.find(params[:id])
   if @vehicle_sale.update(vehicle_sales_params)
    flash[:success] = 'Vehicle_sales Data was successfully updated'
    #render :edit
    redirect_to vehicle_sale_url(@vehicle_sale)
    
   else
    flash.now[:danger] = 'Update was not suucessful'
    render :edit
    #redirect_to vehicle_sales_url
   end
 end 
 
 def destroy
   @vehicle_sale = VehicleSale.find(params[:id])
    @vehicle_sale.destroy if (@vehicle_sale)
    #redirect_to vehicle_sales_url
    render :destroy
 end
 
 
 
 
 
private
 
   
     
   def vehicle_sales_params
    params.require(:vehicle_sale).permit(:vehicle_id,
    :date, :maintenance, :insurance, :highway, :others,
    :fuel, :mileage, :fuel_consumption, :direct_labor_cost,
    :indirect_labor_cost, :special_cost, :other_cost,
    :sales_month, :profit_month)
   end
   
end
    
