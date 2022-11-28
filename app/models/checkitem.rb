class Checkitem < ApplicationRecord
    
    has_many :checkimages, index_errors: true, dependent: :destroy
    
    accepts_nested_attributes_for :checkimages
end
