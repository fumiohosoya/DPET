class CardEvalsController < ApplicationController
    def index
        @allcompanies = allcompanies
    end
    
    def check
        @company_id = params[:company]
    end
    
    def checkresult
         upload_file = params[:card_eval][:file_name]
         send_params = card_eval_params
         @year = send_params["yearmonth(1i)"]
         @month = send_params["yearmonth(2i)"]
         @company_id = send_params[:company_id]
         @branch_id = send_params[:branch_id]
         logger.debug(send_params.inspect)
         tmpdata = []
         @result = []
         if upload_file.present?
            first = true
            CSV.foreach(upload_file.tempfile.path, encoding: "CP932:UTF-8") do |row|
                if first
                    first = false; next; 
                end
                tmpdata << row
            end
            
           @data = tmpdata.slice(0, tmpdata.count - 3)
           @data.each do |e|
             tmprecord = find_or_create_driver_evaluate(e, @company_id, @branch_id, @year, @month)
             @result << tmprecord
           end
         end

    end
    
    private
    
    def find_or_create_driver_evaluate(record,  company, branch, year, month)
        name = record[0] 
        drv =Driver.find_or_create_by(name: name, company: company, branch: branch)
        if (!drv.persisted?)
            drv.password = SecureRandom.hex(5)
            drv.email = "xxx@example.com"
            drv.save!
        end
        op_count = record[1]
        empty_conv = record[2]
        occupied_conv = record[3]
        mileage = record[4]
        handling = timerecord_2_datetime(record[5])
        speedover = record[6]
        spover_time = timerecord_2_datetime(record[7])
        scramble = record[8]
        rapid_accel = record[9]
        abrupt_decel = record[10]
        idling = timerecord_2_datetime(record[11])
        running = timerecord_2_datetime(record[11])
        evaluate = record[13]
        rank = record[14].tr('Ａ-Ｚ', 'A-Z')
        recordmonth = Date.new(year.to_i, month.to_i).end_of_month
        if ((eval = CardEval.find_by(driver_id: drv.id, recordmonth: recordmonth)) != nil)
           eval.update(
                op_count: op_count, empty_conv: empty_conv, occupied_conv: occupied_conv,
                mileage: mileage, handling: handling, speedover: speedover, spover_time: spover_time,
                scramble: scramble, rapid_accel: rapid_accel, abrupt_decel: abrupt_decel,
                idling: idling, running: running, evaluate: evaluate, rank: rank,
           )
           return eval
        else
            eval = CardEval.new(driver_id: drv.id,
                op_count: op_count, empty_conv: empty_conv, occupied_conv: occupied_conv,
                mileage: mileage, handling: handling, speedover: speedover, spover_time: spover_time,
                scramble: scramble, rapid_accel: rapid_accel, abrupt_decel: abrupt_decel,
                idling: idling, running: running, evaluate: evaluate, rank: rank,
                recordmonth: recordmonth
            )
            eval.save
            return eval
        end
    end
    
    def card_eval_params
        params.require(:card_eval).permit("yearmonth(1i)", "yearmonth(2i)", "yearmonth(3i)", :month, :file_name, :company_id, :branch_id)
    end
end