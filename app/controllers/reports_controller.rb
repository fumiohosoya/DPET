class ReportsController < ApplicationController 
    
    before_action :require_driver_logged_in, only:[:new, :create]
    
    def new
        @driver = current_driver
        @reports = @driver.reports.where(checkdate:nil)
        @report = @driver.reports.build
        @trucks = @driver.trucks
        if (!(@trucks.any?))
           @trucks = alltruckmodels(@driver.branch)
        end
    end
    
    def create
        @driver = current_driver
        @report = @driver.reports.build(report_params)
        if (@report.save)
            flash[:success] = "Report registered"
            redirect_to topmenu_url(id:@driver.id)
        else
            render :new
        end
    end
    
    def show
        @report = Report.find(params[:id])
        @user = current_user

    end
    
    def confirm
        @report = Report.find(params[:id])
        @report.checkdate = Time.now
        @report.save
        redirect_to current_user
    end
    
    private
    
    def report_params
    
        params.require(:report).permit(:driver_id, :company_id, :branch_id, :truck_id,
                :title, :content, :image)
    end
end
