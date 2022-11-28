class Truck < ApplicationRecord
    
    has_many :truckrelations, dependent: :destroy
 
    has_many :drivers, through: :truckrelations, source: :driver
    
    has_one :fueltarget

end
