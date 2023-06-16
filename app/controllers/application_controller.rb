class ApplicationController < ActionController::Base
  
  include SessionsHelper
  include DriversHelper
  include AdminsessionsHelper
  
  private
  
  def require_user_logged_in 
      unless logged_in? || adminlogged_in?
          redirect_to login_url
      end
  end
  
   def require_driver_logged_in
    unless driverlogged_in?
      redirect_to driverlogin_url
    end
  end
  
  
  def timerecord_2_datetime(rec_str)
    if (rec_str.present?)
       (h, m) = rec_str.scan(/([0-9]+):([0-9]+)/)[0].map {|e| e.to_i} 
       return Time.at((h * 3600) + (m * 60)).utc
    else
      return nil
    end
  end
  

  def require_admin_logged_in
    unless adminlogged_in?
      redirect_to adminlogin_url
    end
  end
  
end 

