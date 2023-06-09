class Checkitem < ApplicationRecord
    
    extend OrderAsSpecified  #gem order_as_specified which like MySQL field
    
    has_many :checkimages, index_errors: true, dependent: :destroy
    
    accepts_nested_attributes_for :checkimages
    
    
    validate :imagecheck
    
    def imagecheck
        if (checkimages.blank?)
            errors.add(:checkimages, "No Image saved!")
        end
    end
end
