class VehicleSale < ApplicationRecord
    def fuel_consumption
        if self.mileage.present? && self.fuel.present?
         self.mileage / self.fuel
        end
    end
    
    def set_fuel_consumption
        {:fuel_consumption => fuel_consumption }
    end
    
    def fuel_cost
        if self.fuel_price.present? && self.fuel.present?
            self.fuel_price * self.fuel
        end 
    end
    
    def total_cost
        if self.present? 
        #( maintenance && insurance && highway && others && direct_labor_cost && indirect_labor_cost && special_cost && other_cost )   
        #    (maintenance.present? self.insurance.present? self.highway.present?,
        #self.others.present? self.direct_labor_cost.present?
        #self.indirect_labor_cost.present? special_cost.present? other_cost.present? 
        
        # puts [ "maintenance", "insurance",  "highway",  "others",
        # "direct_labor_cost",  "indirect_labor_cost", 
        # "special_cost",  "other_cost" ].sum
          #self.maintenance + self.insurance + self.highway +
          #self.direct_labor_cost +  self.indirect_labor_cost +
          #self.special_cost + self.other_cost
          
        #   temp = 0
          
        #   temp += self.maintenance if self.maintenance.present?
        #   temp += self.insurance   if self.insurance.present?
        #   temp += self.highway     if self.highway.present?
        #   temp += self.others      if self.others.present?
        #   temp += self.direct_labor_cost if self.direct_labor_cost.present?
        #   temp += self.indirect_labor_cost if self.indirect_labor_cost.present?
        #   temp += self.special_cost if self.special_cost.present?
        #   temp += self.other_cost   if self.other_cost.present?
          
        #   return temp
          
          
          array = [ "maintenance", "insurance",  "highway",  "others", "fuel_cost",
                "direct_labor_cost",  "indirect_labor_cost", 
                "special_cost",  "other_cost" ]
                
            total_cost = 0
            array.each do |element|
               if (eval("self.#{element}.present?"))
                   total_cost += eval("self.#{element}")
               end
            end
            return total_cost
        end
    end
    
    def set_total_cost
        {:total_cost => total_cost }
    end
    
    def profit_month
        if self.sales_month.present? && self.total_cost.present?
         self.sales_month - self.total_cost
        end
    end
         
end 
    
  
    
    
