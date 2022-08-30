require 'net/http'
require 'uri'

module DriversHelper

  def current_driver
    @current_driver ||= Driver.find_by(id: session[:driver_id])
  end

  def driverlogged_in?
    !!current_driver
  end



def allcompanies
    
    url = 'https://logiccs.herokuapp.com/companies/all'
    uri = URI.parse(url)
    json = Net::HTTP.get(uri)
    result = JSON.parse(json)
end


def allbranches(id)
    url = "http://logiccs.herokuapp.com/branches/#{id}/all.json"
    uri = URI.parse(url)
    json = Net::HTTP.get(uri)
    result = JSON.parse(json)
end


def alltrucks(branchid)
#  if (@alltrucks == nil)
    url = "http://logiccs.herokuapp.com/trucks/#{branchid}/all.json"
    uri = URI.parse(url)
    json = Net::HTTP.get(uri)
    @alltrucks = JSON.parse(json)
#  else
#    @alltrucks
#  end
end

def alltruckmodels(branchid)
  trucks = []
  alltrucks = alltrucks(branchid)
  alltrucks.each do |t|
    t.delete("dealercompany_id")
    image_url = t["image"]["url"]
    thumb_url = t["image"]["thumb"]["url"]
    t.delete("image")
    trucks << Truck.new(t)
    trucks.last.image_url = image_url
    trucks.last.thumb_url = thumb_url
  end
end

def gettruck(trucknumber)

    uritrucknumber = URI.encode(trucknumber)
    url = "http://logiccs.herokuapp.com/trucks/numbershow.json?number=#{uritrucknumber}"
    uri = URI.parse(url)
    json = Net::HTTP.get(uri)
    result = JSON.parse(json)    
end

  def find_company(id)
    @allcompaniesarray = allcompanies if (@allcompaniesarray == nil)
    return Company.new( @allcompaniesarray.find{|e| e["id"] == id.to_i} )
  end
  
  def getallbranch_array(c_id)
    @allbranchesarray = {} if (@allbranchesarray == nil)
    @allbranchesarray[c_id] = allbranches(c_id) if (@allbranchesarray[c_id] == nil)
    return @allbranchesarray[c_id]
  end
  
  def find_branch(c_id, id)
    branchesarray = getallbranch_array(c_id)
    return Branch.new(branchesarray.find{|e| e["id"] == id})
  end

end
