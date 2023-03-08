class MileageproofsController < ApplicationController
    
    def create
               
       @mileageproof = Mileageproof.new(mileageproof_params)
       @mileageproof.type = "Mileageproof"
       if (@mileageproof.save)
           flash[:success] = "MileageProof Photo saved"
           redirect_to topmenu_url(@mileageproof.driver_id)
       else
           
           flash[:error] = "MileageProof Photo not Saved, Please Set Again"
           unless (@mileageproof.checkimages.any?)
               @mileageproof.checkimages.build
           end
           @driver = Driver.find(@mileageproof.driver_id)
  
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
           render 'drivers/topmenu'
       end
    end
    
private
    
    def mileageproof_params
       params.require(:mileageproof).permit(:driver_id, checkimages_attributes:[:image, :image_cache])
    end
    
    
end
