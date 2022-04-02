class Driver < ApplicationRecord


  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :company, presence: true
  validates :branch, presence: true
  validates :blood_type, presence: true
  validates :age, presence: true
  has_secure_password    
    
    has_many :truckrelations
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
end
