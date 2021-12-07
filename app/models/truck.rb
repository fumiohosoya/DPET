class Truck < ApplicationRecord
    
    has_many :truckrelations
    
    has_many :drivers, through: :truckrelations, source: :driver

end
