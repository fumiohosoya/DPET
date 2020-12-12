class DriversController < ApplicationController
 def index
    render plain: 'ここがドライバー入力画面です'
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
 
 
 
  private
  
   def driver_params
    params.require(:driver).permit(:name, :sex, :date_birth, :age,
      :hire_date, :blood_type, :chronic_disease, :accident_record, 
      :vioration_record)
   end
end
