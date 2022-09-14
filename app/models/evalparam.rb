class Evalparam < ApplicationRecord
    
    validates :fuelA, presence: true,
             numericality: { only_integer: true, greater_than_or_equal_to:0, less_than_or_equal_to: 200 }
    validates :fuelB, presence: true,
             numericality: { only_integer: true, greater_than_or_equal_to:0, less_than_or_equal_to: 150 }
    validates :fuelC, presence: true,
             numericality: { only_integer: true, greater_than_or_equal_to:0, less_than_or_equal_to: 100 }
    validates :fuelD, presence: true,
             numericality: { only_integer: true, greater_than_or_equal_to:0, less_than_or_equal_to: 100 }
    validates :fuelE, presence: true,
             numericality: { only_integer: true, greater_than_or_equal_to:0, less_than_or_equal_to: 100 }
    validates :fuelF, presence: true,
             numericality: { only_integer: true, greater_than_or_equal_to:0, less_than_or_equal_to: 100 }
    validates :balanceSafety, presence: true,
         numericality: {greater_than_or_equal_to: 0.0, less_than_or_equal_to: 100.0 }
    validates :balanceCheck,  presence: true,
         numericality: {greater_than_or_equal_to: 0.0, less_than_or_equal_to: 100.0 }
    validates :balanceFuel,   presence: true,
         numericality: {greater_than_or_equal_to: 0.0, less_than_or_equal_to: 100.0 }
end
