require 'net/http'
require 'uri'

module DriversHelper

  def current_driver
    @current_driver ||= Driver.find_by(id: session[:driver_id])
  end

  def driverlogged_in?
    !!current_driver
  end
  
   def get_json(location, limit = 10)
    raise ArgumentError, 'too many HTTP redirects' if limit == 0
    uri = URI.parse(location)
 
    begin
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.open_timeout = 5
        http.read_timeout = 10
        http.get(uri.request_uri)
      end
 
      case response
      when Net::HTTPSuccess
        json = response.body
        JSON.parse(json)
      when Net::HTTPRedirection
        location = response['location']
        warn "redirected to #{location}"
        get_json(location, limit - 1)
      else
        puts [uri.to_s, response.value].join(" : ")
        nil
      end
    rescue => e
      puts [uri.to_s, e.class, e].join(" : ")
      nil
    end
   end
 



  def allcompanies
      url = 'https://logiccs.herokuapp.com/companies/all'
      result = get_json(url)
      return result
  #    uri = URI.parse(url)
  #    json = Net::HTTP.get(uri)
  #    result = JSON.parse(json)
  end

  def allcompanies_model
    json = allcompanies
    return json.map{|e| Company.new(e.symbolize_keys)}
  end

  def array_find_by(ar, id)
      return nil if id == 0
      return (ar && id) ? ar.find {|e| e && e.id == id.to_i} : nil
  end


  def allbranches(id)
      url = "http://logiccs.herokuapp.com/branches/#{id}/all.json"
      result = get_json(url)
      return result
  #    uri = URI.parse(url)
  #    json = Net::HTTP.get(uri)
  #    result = JSON.parse(json)
  end

  def branches_by_cid_model(id)
    json = allbranches(id)
  
    return json.map{|e| Branch.new(e.symbolize_keys)}
  end


  def allbranchesmodel
      url = "http://logiccs.herokuapp.com/branches/allall"
      
      parsed_json = get_json(url)
  #    uri = URI.parse(url)
  #    json = Net::HTTP.get(uri)
  #    parsed_json = JSON.parse(json)
      return parsed_json.map{|e| Branch.new(e.symbolize_keys)}
  end



  def alltrucks(branchid)
  #  if (@alltrucks == nil)
      url = "http://logiccs.herokuapp.com/trucks/#{branchid}/all.json"
      @alltrucks = get_json(url)
  #    uri = URI.parse(url)
  #   json = Net::HTTP.get(uri)
      
  #    @alltrucks = JSON.parse(json)
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
      symh = t.symbolize_keys
      trucks << Truck.new(symh)
      trucks.last.image_url = image_url
      trucks.last.thumb_url = thumb_url
    end
    return trucks
  end

    def gettruck(trucknumber)
    
        uritrucknumber = URI.encode(trucknumber)
        url = "http://logiccs.herokuapp.com/trucks/numbershow.json?number=#{uritrucknumber}"
        uri = URI.parse(url)
        return get_json(uri)
        
  #      json = Net::HTTP.get(uri)
  #      result = JSON.parse(json)    
    end

  def gettruck_by_id(id)
    uri_id = URI.encode(id.to_s)
    url = "http://logiccs.herokuapp.com/trucks/#{uri_id}/json"
    
    return get_json(url)
    
    
#    uri = URI.parse(url)
#    json = Net::HTTP.get(uri)
#    status = json.code
#    if (status.to_i == 404)
#      result = nil
#    else
#      result = JSON.parse(json)    
#    end
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
    branchesarray = getallbranch_array(c_id.to_i)
    return Branch.new(branchesarray.find{|e| e["id"] == id.to_i})
  end
  
  def thai_trans(s)
    
    thai_hash = {
      "Meters" => "เครื่องวัด / เมตร",
      "Brake & Side Brake" => "เบรกและเบรกข้าง",
      "Lamps & Stopper & Tire Easy Check" => "หลอดไฟ & จุกปิด & การเช็คยางอย่างง่าย",
      "Lamps  Stopper  Tire Easy Check" => "หลอดไฟ สต๊อปเปอร์ไฟเบรค ยาง เช็คแบบง่าย",
      "Engine Oil" => "น้ำมันเครื่อง",
      "Air Reserver" => "ถังลม",
      "Battery" => "แบตเตอรี่",
      "Tires" => "ยางรถ",
      "Oils & Tanks" => "น้ำมันและถัง",
      "Grease Up" => "อัดจารบี",
      "Cab Up" => "ยกหัวเก๋ง",
      "Send Photo" => "ส่งรูป / ภาพถ่าย",
      "Photo saved" => "บันทึกรูปภาพ ",
      "Photo not Saved Please Set Again" => "หากบันทึกรูปภาพไม่ได้ โปรดตั้งค่าอีกครั้ง",
      "Photo/Data not Saved Please Set Again" => "หากบันทึกรูปภาพ / บันทึกข้อมูลไม่ได้ โปรดตั้งค่าอีกครั้ง",
      "Lamp" => "ไฟ",
      "Stopper" => "สต๊อปเปอร์ไฟเบรค",
      "Oil Drops" => "น้ำมันหยดหรือไม่",
      "Today's CheckList" => "รูปภาพถูกบันทึกแล้ว",
      "Trouble Report" => "รายงานปัญหา",
      "Today's Result" => "ผลลัพท์วันนี้",
      "Truck Number" => "เลขทะเบียน",
      "Mileage" => "เลขไมล์",
      "Fuel" => "น้ำมันเชื้อเพลิง",
      "Destination" => "ปลายทาง",
      "Login Succeeded" => "ลงชื่อเข้าใช้สำเร็จ",
    }
    
    return (t = thai_hash[s]) ? s + "- " + t : s
    
  end

end
