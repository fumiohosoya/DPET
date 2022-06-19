class Branch < ApplicationRecord
    
    validate :name,    presence: true
    validate :company_id, presence: true
   
    
    
    def self.json2model(data)
#        [{"id"=>1, "company_id"=>1, "name"=>"Lakrabang", "created_at"=>"2017-07-01T20:32:29.807+07:00", "updated_at"=>"2017-07-01T20:32:29.807+07:00"}, {"id"=>2, "company_id"=>1, "name"=>"Leamchabang", "created_at"=>"2017-07-01T20:32:29.826+07:00", "updated_at"=>"2017-07-01T20:32:29.826+07:00"}, {"id"=>3, "company_id"=>1, "name"=>"Rayong", "created_at"=>"2017-07-01T20:32:29.833+07:00", "updated_at"=>"2017-07-01T20:32:29.833+07:00"}, {"id"=>4, "company_id"=>1, "name"=>"Ayuthaya", "created_at"=>"2017-07-01T20:32:29.848+07:00", "updated_at"=>"2017-07-01T20:32:29.848+07:00"}]
        data.map {|e| Branch.new(e.transform_keys { |key| key.to_sym rescue key }) }
        
    end
end
