class LampStopperTire < Checkitem
    validates :lamp, numericality: true
    validates :stopper, numericality: true
    validates :oilDrops, numericality: true
end
