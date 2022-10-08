class Driver < ApplicationRecord


  mount_uploader :photo, ImageUploader


  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }, on: :update
  validates :company, presence: true
  validates :branch, presence: true
  validates :blood_type, presence: true, on: :update
  validates :age, presence: true, on: :update
  has_secure_password    
    
    has_many :truckrelations, dependent: :destroy
    has_many :trucks, through: :truckrelations, source: :truck
    has_many :checkitems
    has_many :meters
    has_many :brakes
    has_many :lamp_stopper_tires
    has_many :batteries
    has_many :engine_oils
    has_many :air_reservers
    has_many :tires
    has_many :oil_tanks
    has_many :cabups
    has_many :greaseups
    has_many :evaluates
    has_many :mileageproofs
    has_many :dailyresults
    
    def addtruck(truck)
        self.truckrelations.find_or_create_by(truck_id: truck.id)
    end
    
    def has_meter?(day = 1)
      if (self.meters.any?)
       (Time.now - self.meters.last.created_at ) < (86400 * day)#  24 * 60 * 60
       end
    end
    
    
    def has_brake?(day = 1)
      if (self.brakes.any?)
       (Time.now - self.brakes.last.created_at  < (86400 * day))  && (self.brakes.last.checkimages.count > 1)#  24 * 60 * 60
       end
    end
    
    def has_lampStopperTire?(day = 1)
      if (self.lamp_stopper_tires.any?)
        (Time.now - self.lamp_stopper_tires.last.created_at ) < (86400 * day) && (self.lamp_stopper_tires.last.checkimages.count > 1)#  24 * 60 * 60
      end
    end
    
    def has_battery?(day = 1)
       if (self.batteries.any?)
         (Time.now - self.batteries.last.created_at ) < (86400  * day)#  24 * 60 * 60
       end
    end
    
      def has_greaseup?(day = 1)
        if (self.greaseups.any?)
          (Time.now - self.greaseups.last.created_at ) < (86400 * day)  &&
             (self.greaseups.last.checkimages.count > 1)#  24 * 60 * 60
        end
          
     end
     
     def has_engineoil?(day = 1)
        if (self.engine_oils.any?)
          (Time.now - self.engine_oils.last.created_at ) < (86400 * day) #  24 * 60 * 60
        end
     end
     
     def has_airreserver?(day = 1)
       if (self.air_reservers.any?)
        (Time.now - self.air_reservers.last.created_at ) < (86400 * day) #  24 * 60 * 60
       end
     end
     
     def has_tire?(day = 1)
       if (self.tires.any?)
        (Time.now - self.tires.last.created_at ) < (86400 * day) && (self.tires.last.checkimages.count > 1)#  24 * 60 * 60
       end
     end
     
     def has_oil_tank?(day = 1)
       if (self.oil_tanks.any?)
        (Time.now - self.oil_tanks.last.created_at ) < (86400 * day) && (self.oil_tanks.last.checkimages.count > 1)#  24 * 60 * 60
       end
     end
     
     def has_cabup?(day = 1)
        if (self.cabups.any?)
          (Time.now - self.cabups.last.created_at ) < (86400 * day) #  24 * 60 * 60
        end
     end
     
     def has_mlproof?(day = 7)
        if (self.mileageproofs.any?)
          (Time.now - self.mileageproofs.last.created_at ) < (86400 * day) #  24 * 60 * 60
        else
            nil
        end
     end
     
     def get_checkitempoint(datestr)
         d = Date.parse(datestr)
         year = d.year
         month = d.month
         c = self.pick_checkitem_period(year, month).count
         return ((c / 101.0) * 100.0).ceil(1)
     end
     
     def get_yearly_checkitempoint(year)
         resultarray = []
         monthes =  evaluates.pluck(:updated_at).map{|d| d.strftime("%Y/%m")}
         monthes.each {|m|
          c = self.pick_checkitem_period(m[0..3].to_i, m[5..-1].to_i).count
          monthlyc = ((c / 101.0) * 100.0).ceil(1)
          resultarray << monthlyc
         }
         avg = resultarray.sum / resultarray.length.to_f
         avg = avg.ceil(3) if (resultarray.any?)
             
     end
     
     
     def pick_checkitem_period(year, month)
         firstdate = Date.new(year, month)
         lastdate = firstdate.end_of_month
         self.checkitems.where(created_at: firstdate..lastdate) 
     end
     
     def get_fuelcomsaption(datestr)
         d = Date.parse(datestr)
         year = d.year
         month = d.month
         firstdate = Date.new(d.year, d.month)
         lastdate = firstdate.end_of_month
         rec = self.dailyresults.where(recorddate: firstdate..lastdate)
         if (rec.count > 1) 
             max = rec.maximum(:mileage)
             min = rec.minimum(:mileage)
             diff = max - min
             fuel = rec.sum(:fuel)
             if  (diff != 0.0 && fuel != 0.0)
                 efficient = diff / fuel.to_f 
                 return [efficient.ceil(2), diff]
            else
                return [0.0, 0.0]
            end
         else
             return [0.0, 0.0]
         end
             
     end
     
   def get_yearly_fuelcomsamption(year)
     resultarray = []
     monthes =  evaluates.pluck(:updated_at).map{|d| d.strftime("%Y/%m")}
     monthes.each {|m|
      f = self.get_fuelcomsaption(m)
      resultarray << f[0]
     }
     avg = resultarray.sum / resultarray.length.to_f
     avg = avg.ceil(3) if (resultarray.any?)
   end
     
   def conv_dvalue_to_ranking(value)
     if (Ranking.find_by(company: self.company) == nil)
      rankdata= Ranking.find_by(company: 0)
     end
     rankseed = "F"
     if (value)
         e = rankdata; rhash = {A: e.A, B: e.B, C: e.C, D: e.D, E: e.E}
         rhash.each {|key, val| 
         if (value >= val)
            rankseed = key
            break
          end
        }
    end
    ranking = rankseed.to_s
 end
 
def conv_fuel_to_ranking(value, target)
#     if (Ranking.find_by(company: self.company) == nil)
#      rankdata= Ranking.find_by(company: 0)
#     end
    if (value == nil)
        return 'F'
    end
    rhash = {A: target * 1.1, B: target*1.0, C: target*0.9,
             D: target*0.8, E: target*0.7, F: target*0.6}
     evp = Evalparam.find_by(company_id: self.company)
     if (evp)
        rhash = { A: target * (evp.fuelA/100.0), B: target * (evp.fuelB/100.0),
                  C: target * (evp.fuelC/100.0), D: target * (evp.fuelD/100.0),
                  E: target * (evp.fuelE/100.0), F: target * (evp.fuelF/100.0)
        }
     end
     rankseed = "F"
     rhash.each {|key, val| 
      if (value >= val)
        rankseed = key
        break
      end
    }
    logger.debug 'drivermodel Fuel Ranking ' + rankseed.to_s
    ranking = rankseed.to_s
 end
 
 def get_year_eval(year)
  t = Time.gm(year)
  startdate = t.beginning_of_year
  enddate = t.end_of_year
  evaluateslist = self.evaluates.where(recordmonth: startdate..enddate).order(:updated_at)
  return [nil, nil] if (evaluateslist == nil)
  average = self.evaluates.where(recordmonth: startdate..enddate).average(:evaluate)
  if (average)
      average = average.ceil(3)
  end
  return [evaluateslist, average]
 end


  def get_fuel_target
     target_fuel_mlg = 4.5
     lastr =  self.dailyresults.last
     if (lastr != nil && (truck = Truck.find_by(id: lastr.truck_id)))
      if truck.fueltarget == nil
       target_fuel_mlg = Fueltarget.makedefault(truck)
      else
       target_fuel_mlg = truck.fueltarget
      end
     else
      if ((tr = self.truckrelations).any? && (truckrel = tr.last.truck))
       target = truckrel.fueltarget
       if (target != nil)
           target_fuel_mlg = truckrel.fueltarget.fuel
       else
           target_fuel_mlg = 4.4
       end
      end
     end
     return target_fuel_mlg     
  end
     
end
