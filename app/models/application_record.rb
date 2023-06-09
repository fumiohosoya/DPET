class ApplicationRecord < ActiveRecord::Base
#  protect_from_forgery with: :exception
#  rescue_from ActionController::InvalidAuthenticityToken, with: :rescue_422
      
  self.abstract_class = true

#  def handle_unverified_request
#    raise(ActionController::InvalidAuthenticityToken)
#  end

#  def rescue_422
#    redirect_to '/driverlogin'
#  end
  
  

end
