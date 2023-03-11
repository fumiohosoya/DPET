class Checkitem < ApplicationRecord
    
    has_many :checkimages, index_errors: true, dependent: :destroy
    
    accepts_nested_attributes_for :checkimages
    
    
    validate :imagecheck
    
    def imagecheck
        if (checkimages.blank?)
            errors.add(:checkimages, "No Image saved!")
        end
    end
end
