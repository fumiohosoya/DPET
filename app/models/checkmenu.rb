class Checkmenu < ApplicationRecord
    
    validates :company_id, presence: true
    validates :name, presence: true, length:{maximum: 50}
    
    def self.make_default(company_id)
        Checkmenu.create(company_id: company_id, name: "Engine Oil")
        Checkmenu.create(company_id: company_id, name: "Air Reserver") 
        Checkmenu.create(company_id: company_id, name: "Battery") 
        Checkmenu.create(company_id: company_id, name: "Tires")
        Checkmenu.create(company_id: company_id, name: "Oils & Tanks")
        Checkmenu.create(company_id: company_id, name: "Grease Up")
        Checkmenu.create(company_id: company_id, name: "Cab Up")
       # self.new(company_id: company_id, name: "")
    end
    
end
