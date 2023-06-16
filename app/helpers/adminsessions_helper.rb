module AdminsessionsHelper
  def current_adminuser
    @current_adminuser ||= Admin.find_by(id: session[:admin_id])
  end

  def adminlogged_in?
    !!current_adminuser
  end
end
