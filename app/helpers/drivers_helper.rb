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
  if (@allcompaniesresult == nil)
    url = "http://logiccs.herokuapp.com/trucks/#{branchid}/all.json"
    uri = URI.parse(url)
    json = Net::HTTP.get(uri)
    @allcompaniesresult = JSON.parse(json)
  else
    @allcompaniesresult
  end
end

def gettruck(trucknumber)

    url = "http://logiccs.herokuapp.com/trucks/numbershow.json?number=#{trucknumber}"
    uri = URI.parse(url)
    json = Net::HTTP.get(uri)
    result = JSON.parse(json)    
end

  def find_company(id)
    @allcompaniesarray = allcompanies if (@allcompaniesarray == nil)
    return Company.new( @allcompaniesarray.find{|e| e["id"] == id} )
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
