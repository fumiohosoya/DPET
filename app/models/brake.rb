class Brake < Checkitem
    
    validates :checkimages, image2_count: true
    
    # validate :imagecheck2count
    
    # def imagecheck
    #     if (checkimages.count < 2)
    #         errors.add(:checkimages, "No Image saved!")
    #     end
    # end 
    
end
