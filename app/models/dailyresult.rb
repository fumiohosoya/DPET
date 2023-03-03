class Dailyresult < ApplicationRecord
  belongs_to :driver
  
  validates :mileage, numericality: { greater_than: 0 }
  validates :fuel,    numericality: { greater_than: 0 }
  validates :destination, presence: true, length: {maximum: 255}
  validates :recorddate, presence: true
  
end
