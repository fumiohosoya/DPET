class UsersController < ApplicationController
  include DriversHelper
  before_action :require_user_logged_in, only: [:index, :show]
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @companies = allcompanies_model
    @branches = @companies.map {|c|  branches_by_cid_model(c.id.to_s)[0] }

    @user = User.find(params[:id])
    @company = @user.company
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
      flash[:success] = 'ユーザーを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザー登録に失敗しました'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)

  end 
end


 