class DriversController < ApplicationController
 def index
     #render plain: 'ここがドライバー入力画面です'
     
     @drivers = Driver.all.order(:id).page(params[:page])
 end
 
 def show
  @driver = Driver.find(params[:id])
 end
 
 def new
   @driver = Driver.new
 end
 
 
 def create
  @driver = Driver.new(driver_params)
   if (@driver.save)
     redirect_to @driver
   else
    flash[:error] = "Invalid Driver Data"
    render :new
   end
 end
  
  
 def edit
   @driver = Driver.find(params[:id])
 end  
 
 def update
  
  # /drivers/1   method "PUT"
 @driver = Driver.find(params[:id])
   if @driver.update(driver_params)
    flash[:success] = 'Driver Data was successfully updated'
    #render :edit
    redirect_to driver_url(@driver)
    
   else
    flash.now[:danger] = 'Update was not suucessful'
    render :edit
    #redirect_to drivers_url
   end
 end 
 
 def destroy
   @driver = Driver.find(params[:id])
    @driver.destory if (@driver)
    #redirect_to drivers_url
    render :destroy
 end
 
 
 
 
 
 private
 
   
     
   def driver_params
    params.require(:driver).permit(:name, :sex, :date_birth, :age,
      :hire_date, :blood_type, :chronic_disease, :accident_record, 
      :vioration_record)
   end
 
end