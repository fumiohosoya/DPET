class DriversessionsController < ApplicationController
    
    
def new
    
    @email = params[:email]
    @password = params[:password]
    

end


 def create
    email = params[:driversession][:email].downcase
    password = params[:driversession][:password]
    if login(email, password)
      flash[:success] = thai_trans('Login Succeeded')
      redirect_to topmenu_path(@user)
    else
      flash.now[:danger] = 'Login Failed'
      render :new
    end
  end

  private

  def login(email, password)
    # binding.pry
    @user = Driver.find_by(email: email)
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:driver_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end
  end

end
