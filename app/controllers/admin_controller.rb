class AdminController < ApplicationController

  include  DriversHelper

  def index
  end

  def truckindex
      @companies = allcompanies_model
      @branches = @companies.map {|c|  branches_by_cid_model(c.id.to_s)[0] }
      if (params[:company])
       @target_c = array_find_by(@companies, params[:company])
     else
       @target_c = @companies.first
     end
        
     @trucks = Truck.where(company_id: @target_c.id).order(:company_id, :branch_id, :vehicleid).page(params[:page])
      # @companies = getcompany_array
      
  end
  
  def listdrivers
    @truck = Truck.find_by(number: params[:number])
    @drivers = @truck.drivers
    @relations = @truck.truckrelations
    
    @listeddrivers = Driver.where(branch: @truck.branch_id) - @drivers
  end
  
  def branchusernew
      @user = User.new
  end
  
  def branchusercreate
      @user = User.new(user_params)
      if (@user.save)
          flash[:success] = "User added"
          redirect_to adminpanel_url
      else
          flash[:error] = "User create failed"
          render 'branchusernew'
      end
  end
  
  def branchuserlist
    @companies = allcompanies_model
    @branches = @companies.map {|c|  branches_by_cid_model(c.id.to_s)[0] }
    if (params[:company])
       @target_c = array_find_by(@companies, params[:company])
    else
       @target_c = @companies.first
    end
    @users = User.where(company: @target_c.id).order(:company, :branch, :name).page(params[:page])
  end
  
  def branchuseredit
    @companies = allcompanies_model
    @user = User.find(params[:id])
    @branches =  allbranches(@user.branch)
  end
  
  private
  
  def user_params
      params.require(:user).permit(:name, :email, :password, :company, :branch )
  end
  
  # def getcompany_array
  #   all_c = []
  #   companies = allcompanies
  #   companies.each do |element|
  #     c = Company.new(element)
  #     all_c << c
  #   end
  #   # binding.pry
  #   return all_c
  # end
  


end
