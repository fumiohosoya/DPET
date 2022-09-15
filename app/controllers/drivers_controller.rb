class DriversController < ApplicationController
 
 #before_action :require_driver_logged_in, only:[:topmenu]
 
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
 
 def index
     #render plain: 'ここがドライバー入力画面です'
     
     @companies = allcompanies_model
     @branches = @companies.map {|c|  branches_by_cid_model(c.id.to_s)[0] }
     if (params[:company])
      @target_c = array_find_by(@companies, params[:company])
     else
      @target_c = @companies.first
     end
     @drivers = Driver.where(company: @target_c.id).order(:company, :branch).page(params[:page])
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

  if (@truck.new_record?)
    tinfo = gettruck(number)
    @truck = maketruck_model(tinfo)
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
    redirect_to drivers_url
    
   else
    flash.now[:danger] = 'Update was not suucessful'
    render :edit
    #redirect_to drivers_url
   end
 end 
 
 def destroy
   @driver = Driver.find(params[:id])
    @driver.destroy if (@driver)
    redirect_to drivers_url
 end
 
 def topmenu
  @driver = Driver.find(params[:id])
  
  company_id = @driver.company
  
  if (Checkschedule.find_by(company_id: company_id) == nil)
     Checkschedule.make_default(company_id) 
  end 
  
  #
  todo_hash = {
            "Engine Oil" => [new_engine_oil_path, "has_engineoil?"],
            "Air Reserver" => [new_air_reserver_path, "has_airreserver?"],
            "Battery" => [new_battery_path, "has_battery?"],
            "Tires" => [new_tire_path, "has_tire?"],
            "Oils & Tanks" => [new_oil_tank_path, "has_oil_tank?"],
            "Grease Up" => [new_greaseup_path , "has_greaseup?"],
            "Cab Up" => [new_cabup_path, "has_cabup?"],
            }
            
  today = Time.now
  # today = DateTime.new(2022, 4, 16)   # テスト用
  
  # 前日未実施項目があれば繰り越してチェック
  @prev_todos = Checkschedule.checkItem(today.yesterday, @driver.company)
  
   remain_menu = []
   @prev_todos.each do |p_todo|
     checkname = p_todo.checkmenu.name
     check_todo = todo_hash[checkname][1] 
     if eval("@driver.#{check_todo}(2)")
       #  trueなら実施済み
     else
       remain_menu.push(p_todo)
    end
   end
  
    @todos = Checkschedule.checkItem(today, @driver.company)
    @todos += remain_menu
    @todos = @todos.uniq
    
    @select = nil
    @trucks = @driver.trucks
    if (!(@trucks.any?))
       @trucks = alltruckmodels(@driver.branch)
    end
    @dailyresult = current_driver.dailyresults.last
    if (@trucks.count == 1)
      @select = @trucks.last.id
      if (@daylyresult != nil)
        @min_mileage = @dailyresult.mileage
      else
        @min_mileage = @trucks.last.initmileage
     end
    end
    if (@dailyresult)
      @select = @dailyresult.truck_id
      @min_mileage = @dailyresult.mileage
      # Don't move this cord
      # **Caution** last record is modified by next step with
      # current_driver.dailyresults.bulid
    end
    if  ((@dailyresult == nil) || ((Time.now - @dailyresult.created_at ) > (43200)))
      @dailyresult = current_driver.dailyresults.build
    end
 
 end
 
 def get_year_eval(driver, year)
  t = Time.gm(year)
  startdate = t.beginning_of_year
  enddate = t.end_of_year
  evaluates = driver.evaluates.where(recordmonth: startdate..enddate).order(:updated_at)
  average = driver.evaluates.where(recordmonth: startdate..enddate).average(:evaluate).ceil(3)
  return [evaluates, average]
 end
 
# def conv_dvalue_to_ranking(value)
#   if (Ranking.find_by(company: @company.id) == nil)
#     rankdata= Ranking.find_by(company: 0)
#   end
#   e = rankdata; rhash = {A: e.A, B: e.B, C: e.C, D: e.D, E: e.E}
#   rankseed = "F"
#   rhash.each {|key, val| 
#       if (value >= val)
#         rankseed = key
#         break
#       end
#   }
#   ranking = rankseed.to_s
# end
 
 # should be placed in model?????
 def checkevals(driver, year, month)
    t = Time.gm(year, month)
    startdate = t.beginning_of_month
    enddate = t.end_of_month
    months = driver.checkiiems.where(created_at: startdate..enddate).pluck(:created_at).map { |e| e.beginning_of_month }.uniq.sort
    ev_array = []
    months.each do |m|
     end_m = m.end_of_month
     count = driver.checkitems.where(created_at: m..end_m).count
     ev_array << count.to_f / 100.to_f
    end
    ev = 0.0
    if (ev_array.any?)
     ev = ev_array.sum(0.0) / ev_array.length
    end
    return ev
 end
 
 
 
 def evaluates
   @driver = Driver.find(params[:id])
   @company = find_company(@driver.company)
   
   #@now = Time.now
   @now = params[:year] ? Time.gm(params[:year].to_i) : Time.now
   
   (@evaluates, @average) = get_year_eval(@driver, @now.year.to_i)
   @ranking = @driver.conv_dvalue_to_ranking(@average)
   
   @year_array = @driver.evaluates.pluck(:recordmonth).map{|r| r.year}.uniq.sort
   # @year_array.delete(now.year)
   
 end
 
  def yearlyevaluates
   @driver = Driver.find(params[:id])
   @company = find_company(@driver.company)
   
   #@now = Time.now
   @year = params[:year] || Time.now.localtime.year.to_s
   @now = params[:year] ? Time.gm(params[:year].to_i) : Time.now
   
   (@evaluates, @average) = get_year_eval(@driver, @now.year.to_i)
   @ranking = @driver.conv_dvalue_to_ranking(@average)
   
   @year_hash = {}
   year_array = @driver.evaluates.pluck(:recordmonth).map{|r| r.year}.uniq.sort
   @evaluates.each do |e|
     key = e.updated_at.strftime("%Y/%m")
     @year_hash[key] = {record: e }
   end
   # @year_array.delete(now.year)
      
   @displayflag = Displayflag.find_by(company_id: @driver.company)
   if (@displayflag == nil)
      @displayflag = Displayflag.new(
            company_id: @driver.company, 
            driverfuel: true 
      )
   end
   if (@displayflag.driverfuel)
     @target_fuel_mlg = 4.5
     truck = Truck.find_by(id: @driver.dailyresults.last.truck_id)
     if (truck != nil) 
      if truck.fueltarget == nil
       @target_fuel_mlg = Fueltarget.makedefault(truck)
      else
       @target_fuel_mlg = truck.fueltarget
      end
     else
      truckrel = @driver.truckrelations.last.truck
      if (truckrel)
       @target_fuel_mlg = truckrel.fueltarget.fuel
      end
     end
   end
   
 end
 
 #### followings are Need to MicroAPI
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
      :vioration_record, :email, :password, :password_confirmation,
      :company, :branch, :photo, :image_cache)
   end
 
end