class DisplayflagsController < ApplicationController
  def driverfuelset
    @displayflag = 
      Displayflag.find_or_initialize_by(
        driverfuel_params
      )
    @displayflag.save 
    redirect_back(fallback_location: root_url)
  end
  
  def driverfuelchange
    flag = driverfuel_params
    @displayflag =  Displayflag.find_by(company_id: flag[:company_id])
    @displayflag.update(flag)
    redirect_back(fallback_location: root_url)
  end
  
  
  private
  
  def driverfuel_params
    params.require(:displayflag).permit(:company_id, :driverfuel)
  end
end
