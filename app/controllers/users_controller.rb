class UsersController < ApplicationController
  include DriversHelper
  
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    if (adminlogged_in?)
      redirect_to adminpanel_url
    else
      redirect_to current_user
    end
  end

  def show
    @companies = allcompanies_model

    @user = User.find(params[:id])
    @company = @user.company
    @branches = branches_by_cid_model(@company)
#    binding.pry
    @reports = Report.where(company_id: @user.company, branch_id: @user.branch, checkdate:nil)
    @donereports = Report.where(company_id: @user.company, branch_id: @user.branch).where.not(checkdate:nil).order(:created_at).limit(5)
    @todos = Checkschedule.checkItem(Time.now, @user.company)
    @drivers = Driver.where(branch: @user.branch)

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'User registered'
      redirect_to @user
    else
      flash.now[:danger] = 'User regist failed'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)

  end 
end


 