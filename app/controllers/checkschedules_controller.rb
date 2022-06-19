class CheckschedulesController < ApplicationController
    
    def index
        @allcompanies = allcompanies
    end
    
    def new
        
     @todo = [
            ["Engine Oil", 1],
            ["Air Reserver", 2],
            ["Battery", 3],
            ["Tires", 4],
            ["Oils & Tanks", 5],
            ["Grease Up", 6],
            ["Cab Up", 7],
      ] 
      @company_id = params[:company]
      if (ext1 = Ext1.find_by(company_id: @company_id))
          @todo << [ext1.name, 8]
      end
      if (ext2 = Ext2.find_by(company_id: @company_id))
          @todo << [ext2.name, 9]
      end
      if (Checkschedule.find_by(company_id: @company_id) == nil)
         Checkschedule.make_default(@company_id) 
      end 
      @schedules = Checkschedule.where(company_id: @company_id).order(:dayofweek)
      
      get_current_instances(@company_id, @schedules)
      render :edit
    end
    
   def edit
      
     @todo = [
            ["Engine Oil", 1],
            ["Air Reserver", 2],
            ["Battery", 3],
            ["Tires", 4],
            ["Oils & Tanks", 5],
            ["Grease Up", 6],
            ["Cab Up", 7],
      ] 
      @company_id = params[:id]
      if (ext1 = Ext1.find_by(company_id: @company_id))
          @todo << [ext1.name, 8]
      end
      if (ext2 = Ext2.find_by(company_id: @company_id))
          @todo << [ext2.name, 9]
      end
      if (Checkschedule.find_by(company_id: @company_id) == nil)
         Checkschedule.make_default(@company_id) 
      end 
      @schedules = Checkschedule.where(company_id: @company_id).order(:dayofweek)
      
      get_current_instances(@company_id, @schedules)       
    end
    
    
    def create
        day1 = params[:day1]
        day2 = params[:day2]
        day3 = params[:day3]
        day4 = params[:day4]
        day5 = params[:day5]
        day6 = params[:day6]
        day18 = params[:day18]
        @company_id = params[:company_id]
        @schedules = Checkschedule.where(company_id: @company_id).order(:dayofweek)

        @day1 = @schedules.find_by(dayofweek: 1).update(checkmenu_id: day1)
        @day2 = @schedules.find_by(dayofweek: 2).update(checkmenu_id: day2)
        @day3 = @schedules.find_by(dayofweek: 3).update(checkmenu_id: day3)
        @day4 = @schedules.find_by(dayofweek: 4).update(checkmenu_id: day4)
        @day5 = @schedules.find_by(dayofweek: 5).update(checkmenu_id: day5)
        @day6 = @schedules.find_by(dayofweek: 6).update(checkmenu_id: day6)
        @day18 = @schedules.find_by(dayofweek: 18).update(checkmenu_id: day18)
        
        redirect_to checkschedule_url(@company_id)
    end
    
 
    def show
       @company_id = params[:id] 
       @schedules = Checkschedule.where(company_id: @company_id).order(:dayofweek)

       get_current_instances(@company_id, @schedules)
    end
    
    def make_default
        @company_id = params[:id]
        Checkschedule.reset_to_default(@company_id)
        redirect_to checkschedule_url(@company_id)
    end
    
    def makeext1
        @company_id = params[:id]
        @ext1 = Ext1.find_by(company_id: @company_id)
        if (@ext1 == nil)
            @ext1 = Ext1.new
        end
    end
   
    def makeext2
        @company_id = params[:id]
        @ext2 = Ext2.find_by(company_id: @company_id)
        if (@ext2 == nil)
            @ext2 = Ext2.new
        end
    end
   
private

  def get_current_instances(company_id, schedules)
      @day1 = schedules.find_by(dayofweek: 1).checkmenu
      @day2 = schedules.find_by(dayofweek: 2).checkmenu
      @day3 = schedules.find_by(dayofweek: 3).checkmenu
      @day4 = schedules.find_by(dayofweek: 4).checkmenu
      @day5 = schedules.find_by(dayofweek: 5).checkmenu
      @day6 = schedules.find_by(dayofweek: 6).checkmenu
      @day18 = schedules.find_by(dayofweek: 18).checkmenu      
  end


end
