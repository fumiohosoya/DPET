require 'net/http'
require 'uri'


def allcompanies
    
    url = 'https://logiccs.herokuapp.com/companies/all'
    uri = URI.parse(url)
    json = Net::HTTP.get(uri)
    result = JSON.parse(json)
end


  def getallcompany_array
    all_c = []
    companies = allcompanies
    
    companies.each do |element|
      
      c = Company.new(element)
      all_c << c
    end
    return all_c
  end
