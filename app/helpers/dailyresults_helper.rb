module DailyresultsHelper
    
=begin
<datalist id="destinationOptions">

  <option value="San Francisco">
  <option value="New York">
  <option value="Seattle">
  <option value="Los Angeles">
  <option value="Chicago">
</datalist>
=end
  
  def destination_opt_sel
    company_ds = Destination.where(company_id: @driver.company).pluck(:destination)
    if ((@driver.dailyresults.any?) &&
        (@dests = @driver.dailyresults.pluck(:destination).uniq&.sort!))
        # bs5_datalist = %Q!<datalist id="destinationOptions">!
         return (@dests + company_ds).sort&.uniq
    else
      return []
    end
  end
end
