class ApplicationController < ActionController::Base
  
  include SessionsHelper
  include DriversHelper
  
  private
  
  def require_user_logged_in 
      unless logged_in?
          redirect_to login_url
      end
  end
  
   def require_driver_logged_in
    unless driverlogged_in?
      redirect_to driverlogin_url
    end
  end
end 
