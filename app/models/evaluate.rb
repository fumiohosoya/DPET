class Evaluate < ApplicationRecord
  belongs_to :driver
  
  validate :recordmonth, presence: true
end
