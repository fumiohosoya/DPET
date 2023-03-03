class Destination < ApplicationRecord
    validates :company_id, presence: true
    validates :destination, presence: true, length:{maximum: 255}, uniqueness: true
end
