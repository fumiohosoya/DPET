class Evaluate < ApplicationRecord
  belongs_to :driver
  
  validates :recordmonth, presence: true
end
