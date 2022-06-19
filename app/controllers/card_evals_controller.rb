class CardEvalsController < ApplicationController
    def index
        @allcompanies = allcompanies
    end
    
    def check
        @company_id = params[:company]
    end
    
    def checkresult
         upload_file = params[:card_eval][:file_name]
         @data = []
         if upload_file.present?
             
#               File.open(upload_file.tempfile.path, "r:bom|cp932") do |f|
#                 @data = SmarterCSV.process(f, {file_encoding: 'cp932'});
#               end
            first = true
            CSV.foreach(upload_file.tempfile.path, encoding: "CP932:UTF-8") do |row|
                if first
                    first = false; next; 
                end
                @data << row
            end
         end
    end
    
    private
    
    def card_eval_params
   #     params.require(:card_eval).permit(:year, :month, :file_name, :company_id, :branch_id)
    end
end