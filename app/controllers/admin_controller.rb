class AdminController < ApplicationController

  include  DriversHelper

  def index
  end

  def truckindex
      @trucks = Truck.all.order("company_id and branch_id and vehicleid")
      # @companies = getcompany_array
      
  end
  
  def listdrivers
    @truck = Truck.find_by(number: params[:number])
    @drivers = @truck.drivers
  end
  
  private
  
  # def getcompany_array
  #   all_c = []
  #   companies = allcompanies
  #   companies.each do |element|
  #     c = Company.new(element)
  #     all_c << c
  #   end
  #   # binding.pry
  #   return all_c
  # end
  


end
