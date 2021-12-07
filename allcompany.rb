require 'net/http'
require 'uri'


def allcompany
    
    url = 'https://logiccs.herokuapp.com/companies/all'
    
    uri = URI.parse(url)
    json = Net::HTTP.get(uri)
    
    result = JSON.parse(json)
    
end


allc = allcompany

#p allc

#p allc[0]

#p allc[0]["name_e"]

p    allc.collect { |p| [ p["name_e"], p["id"] ] }