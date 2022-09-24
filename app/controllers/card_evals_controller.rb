class CardEvalsController < ApplicationController
    def index
     @companies = allcompanies_model
     @branches = @companies.map {|c|  branches_by_cid_model(c.id.to_s)[0] }
     if (params[:company])
      @target_c = array_find_by(@companies, params[:company])
      @company_id = params[:company]
     else
      @target_c = @companies.first
      @company_id = @target_c.id.to_s
     end
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
            detection = CharlockHolmes::EncodingDetector.detect(File.read(upload_file.tempfile.path))

            # CharlockHolmes::EncodingDetectorのディテクション結果は、
            # CP932であるShift JIS拡張文字コードを含む場合にもShift_JISと見なされてしまう為、CP932を優先して利用する。
            # もしそのままShift JISを指定すれば、CSV.foreach()で変換エラーが出る原因となる。
            # アップサイドは拡張文字コードを変換できることで、ダウンサイドは7種類の記号文字の見た目が完全に一致しないこと。

            encoding = detection[:encoding] == 'Shift_JIS' ? 'CP932' : detection[:encoding]
            encoding = 'CP874' if encoding == 'ISO-8859-6'
            encoding = 'CP874' if encoding == 'ISO-8859-11'
            # タイ語版 Windows向けと推測されるのExcelデータの場合は強制的に CP874に変更
            #  本来 ISO-8859-6はアラビア語文字エンコーディング ISO-8859-11がタイ語文字エンコーディング
            CSV.foreach(upload_file.tempfile.path,
                        encoding: "#{encoding}:UTF-8",  headers: true) do |row|
                if first
                    first = false; next; 
                end
                break if row[0] == "รวม" || row[0] == "合計値"
                    
                tmpdata << row
            end
            
           @data = tmpdata
           @data.each do |e|
             tmprecord = find_or_create_driver_evaluate(e, @company_id, @branch_id, @year, @month)
             @result << tmprecord
           end
         end

    end
    
    def listresults
        @companies = allcompanies_model
        @branches = @companies.map {|c|  branches_by_cid_model(c.id.to_s)[0] }
        if (params[:company])
          @target_c = array_find_by(@companies, params[:company])
          @company_id = params[:company]
        else
          @target_c = @companies.first
          @company_id = @target_c.id.to_s
        end
        @drivers = Driver.where(company: @company_id).order(:branch, :name)
        if @drivers.any?
            @branches = @drivers.pluck(:branch).uniq!.delete_if{|x| x == nil}
        else
            @branches = []
        end
    end
    
    def summary
        @companies = allcompanies_model
        @branches = @companies.map {|c|  branches_by_cid_model(c.id.to_s)[0] }
        if (params[:company])
          @target_c = array_find_by(@companies, params[:company])
          @company_id = params[:company]
        else
          @target_c = @companies.first
          @company_id = @target_c.id.to_s
        end
        @drivers = Driver.where(company: @company_id).order(:branch, :name)
        if @drivers.any?
            @branches = @drivers.pluck(:branch).uniq!.delete_if{|x| x == nil}
        else
            @branches = []
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
        # op_count = record[1] empty_conv = record[2] occupied_conv = record[3] mileage = record[4]
        (op_count, empty_conv, occupied_conv, mileage) = record[1..4]
        handling = timerecord_2_datetime(record[5])
        speedover = record[6]
        spover_time = timerecord_2_datetime(record[7])
        # scramble = record[8] rapid_accel = record[9] abrupt_decel = record[10]
        (scramble, rapid_accel, abrupt_decel) = record[8..10]
        idling = timerecord_2_datetime(record[11])
        running = timerecord_2_datetime(record[12])
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
    
  private
    
    def card_eval_params
        params.require(:card_eval).permit("yearmonth(1i)", "yearmonth(2i)", "yearmonth(3i)", :month, :file_name, :company_id, :branch_id)
    end
end