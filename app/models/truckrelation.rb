class Truckrelation < ApplicationRecord
  belongs_to :truck
  belongs_to :driver
end
