class Fueltarget < ApplicationRecord
  belongs_to :truck
  
#==begin
#4輪　14㎞
#6輪　5.5㎞
#10輪　4.5㎞
#10Wトラクターヘッド　3㎞
#６Wトラクターヘッド　3.5㎞
#==end

  def default(truck)
      default_hash = {4=>14.0, 6=>5.5, 10=>4.5, 12=>3.0}
      
      val = 14.0
      if (truck.body == "Tractor Head") 
          if (truck.wheels == 6)
            val = 3.5 
          else (truck.wheels == 10)
            val = 3.0
          end
      else
        val = default_hash[truck.wheels]
      end
      return val ? val : 999.9;
  end
  
  def self.makedefault(truck)
    
    return Fueltarget.new.default(truck)
  end
end
