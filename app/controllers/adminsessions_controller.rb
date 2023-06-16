class AdminsessionsController < ApplicationController
  def new
  end

  def create
    email = params[:adminsession][:email].downcase
    password = params[:adminsession][:password]
    if login(email, password)
      flash[:success] = 'adminlogin'
      redirect_to adminpanel_url
    else
      flash.now[:danger] = 'Admin login Failed'
      render :new
    end 
  end

  def destroy
    session[:admin_id] = nil
    flash[:success] = 'Admin logged out'
    redirect_to root_url
  end
  
  private
  
  def login(email, password)
    @admin = Admin.find_by(email: email)
    if @admin && @admin.authenticate(password)
      # ログイン成功
      session[:admin_id] = @admin.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
end
