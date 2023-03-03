class LampStopperTire < Checkitem
    
    validates :checkimages, image2_count: true

    validates :lamp, presence: true, numericality: true
    validates :stopper, presence: true, numericality: true
    validates :oilDrops, presence: true, numericality: true
end
