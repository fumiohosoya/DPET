class DriversController < ApplicationController
 
 #before_action :require_driver_logged_in, only:[:topmenu]
 
 include DriversHelper
 
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
  
  number = params[:trucknumber]
  
  @truck = Truck.find_or_initialize_by(number: number)
   # binding.pry

  if (@truck.new_record?)
    tinfo = gettruck(number)

    @truck.company_id = tinfo["company_id"]
    @truck.branch_id  = tinfo["branch_id"]
    @truck.maker = tinfo["maker"]
    @truck.model = tinfo["model"]
    @truck.body = tinfo["body"]
    @truck.wheels = tinfo["wheels"]
    @truck.year = tinfo["year"]
    @truck.age = tinfo["age"]
    @truck.engine = tinfo["engine"]
    @truck.vehicleid = tinfo["vehicleid"]
    @truck.number = tinfo["number"]
    @truck.e_oil = tinfo["e_oil"]
    @truck.tm_oil = tinfo["tm_oil"]
    @truck.tire = tinfo["tire"]
    @truck.df_oil = tinfo["df_oil"]
    @truck.initmileage = tinfo["initmileage"]
    @truck.purchase = tinfo["purpurchase"]
    @truck.image_url = tinfo["image_url"]
    @truck.thumb_url = tinfo["thumb_url"]
    @truck.created_at = tinfo["created_at"]
  end
  if (@driver.save)
     @truck.save
     @driver.addtruck(@truck)
     
    if (@truck.truckrelations.count > 3)
          flash[:error] = "Caution!!: Driver Entries over 3"
     end
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
    @driver.destroy if (@driver)
    #redirect_to drivers_url
    render :destroy
 end
 
 def topmenu
  @driver = Driver.find(params[:id])
#  @todos = Checkschedule.checkItem(Time.now, @driver.company)
  @todos = Checkschedule.checkItem(DateTime.new(2021, 11, 6), @driver.company)
 end
 
 
 def update_branch_menus
  
   company_id = params[:company]
   
   menus = allbranches(company_id)
   
   @subhtml = "<option></option>"
   
   menus.each do |e|
     id = e["id"]
     name = e["name"]
     @subhtml += "<option value=#{id}>#{name}</option>" 
   end
   
#   raise "#{@subhtml}"
   
#   render js: 'alert("<%= escape_javascript(#{@subhtml}) %>");'

    render json: @subhtml


 end
 
 
 def update_truck_menus
  
  
   branch_id = params[:branch]
   
   @menus = alltrucks(branch_id)
   
   @subhtml = "<option></option>"
   
   @menus.each do |e|
     number = e["number"]
     @subhtml += "<option value=\"#{number}\">#{number}</option>" 
   end
  
   render json: @subhtml
 end
 
 
 
 
 private
 
   
     
   def driver_params
    params.require(:driver).permit(:name, :sex, :date_birth, :age,
      :hire_date, :blood_type, :chronic_disease, :accident_record, 
      :vioration_record, :email, :password, :password_confirmation, :company, :branch)
   end
 
end