class Checkschedule < ApplicationRecord
  belongs_to :checkmenu
  
  validates :company_id, presence: true
  validates :dayofweek, presence: true
  
  
  def self.make_default(company_id)
    Checkschedule.create(dayofweek: 1, checkmenu_id: 1, company_id: company_id)
    Checkschedule.create(dayofweek: 2, checkmenu_id: 2, company_id: company_id)
    Checkschedule.create(dayofweek: 3, checkmenu_id: 3, company_id: company_id)
    Checkschedule.create(dayofweek: 4, checkmenu_id: 4, company_id: company_id)
    Checkschedule.create(dayofweek: 5, checkmenu_id: 5, company_id: company_id)
    Checkschedule.create(dayofweek: 6, checkmenu_id: 6, company_id: company_id)
    Checkschedule.create(dayofweek: 18, checkmenu_id: 7, company_id: company_id)
  end
  
  def self.reset_to_default(company_id)
    Checkschedule.where(company_id: company_id).delete_all
    self.make_default(company_id)
  end
  
  def self.checkItem(day, company_id)
      wday = day.wday
      if (wday < 6)
          return Checkschedule.where(dayofweek: wday, company_id: company_id)
      elsif (wday == 6) && (day.day < 8)
          # first saturday of the month
          return Checkschedule.where(dayofweek: 6, company_id: company_id)
      elsif (wday == 6) && (day.day > 14) && (day.day < 22)
          # Third saturday of the month
          return Checkschedule.where(dayofweek: 18, company_id: company_id)
          
      else
          return []
      end
  end
  
end
