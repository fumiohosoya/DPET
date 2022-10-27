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
        get_companies_and_target_with_param

        @drivers = Driver.where(company: @company_id).order(:branch, :name)
        if @drivers.any?
            @branches = @drivers.pluck(:branch).uniq!.delete_if{|x| x == nil}
        else
            @branches = []
        end
    end
        
    def summary
        @year_array = []
        get_companies_and_target_with_param
        @now = params[:year] ? Time.gm(params[:year].to_i) : Time.now
        @year = @now.year.to_i
        @drivers = Driver.where(company: @company_id).order(:branch, :name)
        if @drivers.any?
            @year_array =  CardEval.where(driver_id: @drivers.ids).pluck(:recordmonth).map{|r| r.year}.uniq.sort 
            unless (@year_array.include?(@year))
                 @year = @year_array.first
            end
            @branches = @drivers.pluck(:branch).uniq!.delete_if{|x| x == nil}
        else
            @branches = []
        end
        @displayflag = Displayflag.find_by(company_id: @company_id)
        if (@displayflag == nil)
          @displayflag = Displayflag.new(
            company_id: @company_id, 
            driverfuel: true 
            )
        end
        @listhash = {}
        @branches.each do |branch_id|
             driverslist = Driver.where(company: @company_id, branch: branch_id)
             if driverslist.any?
                 resultarray = []
                 driverslist.each do |driver|
                    (safetylist, safetyPts) = driver.get_year_eval(@year)
                    if (safetylist.any?)
                        oneresult = {
                         id: driver.id,
                         name: driver.name, safety:  safetyPts.ceil(2),
                         safetyrank:  driver.conv_dvalue_to_ranking(safetyPts),
                         check:  (checkp = driver.get_yearly_checkitempoint(@year)),
                         checkrank: driver.conv_dvalue_to_ranking(checkp)
                        }
                        evp = Evalparam.find_by(company_id: driver.company)

                        if (@displayflag.driverfuel?)
                            oneresult[:fuel] = mlg = driver.get_yearly_fuelcomsamption(@year) 
                            oneresult[:fuelrank] = fuelrank = driver.conv_fuel_to_ranking(mlg, driver.get_fuel_target)
                            evp = Evalparam.find_by(company_id: driver.company)
                            if (evp)
                                balanceSafety = evp.balanceSafety / 100.0
                                balanceCheck = evp.balanceCheck / 100.0
                                balanceFuel = evp.balanceFuel / 100.0
                            else
                                balanceSafety = (33.30 / 100.0)
                                balanceCheck = (33.40 / 100.0)
                                balanceFuel = (33.30 / 100.0)
                            end
                            fuelpoint_hash = {A: 100, B: 80, C: 60, E: 40, F:20, G: 0}
                            fuelpoint = fuelpoint_hash[fuelrank.to_sym]  
                            if (safetyPts)
                                totalval = safetyPts * balanceSafety + 
                                        (checkp ? checkp : 0.0) * balanceCheck + fuelpoint * balanceFuel
                                oneresult[:totalval] = totalval.ceil(2)
                                oneresult[:totalrank] = driver.conv_dvalue_to_ranking(totalval)
                            end
                        else
                            if (evp)
                                balanceSafety = evp.balanceSafety / (evp.balanceSafety + evp.balanceCheck)
                                balanceCheck =  evp.balanceCheck /  (evp.balanceSafety + evp.balanceCheck)
                            else
                                balanceSafety = 0.5
                                balanceCheck = 0.5
                            end
                            if (safetyPts)
                                totalval = safetyPts * balanceSafety +  checkp * balanceCheck
                                oneresult[:totalval] = totalval.ceil(2)
                                oneresult[:totalrank]= driver.conv_dvalue_to_ranking(totalval)
                            end
                        end
                        resultarray << OpenStruct.new(oneresult)
                    else
                        oneresult = { id: driver.id, name: driver.name,
                                      safety:  "NONE", saftyrank: "NONE" }
                        resultarray << OpenStruct.new(oneresult)
                    end
                 end
                 resultarray.sort! {|a, b| b.totalval.to_f <=> a.totalval.to_f}
                 @listhash[branch_id] = resultarray
             end
        end
    end
 
    
    def find_or_create_driver_evaluate(record,  company, branch, year, month)
        name = record[0] 
        drv =Driver.find_or_create_by(name: name, company: company, branch: branch)
        if (!drv.persisted?)
            drv.password = SecureRandom.hex(5)
            drv.email = "xxx@example.com"
            drv.save(validate: false)
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
    
    
    def get_companies_and_target_with_param
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
    
    def card_eval_params
        params.require(:card_eval).permit("yearmonth(1i)", "yearmonth(2i)", "yearmonth(3i)", :month, :file_name, :company_id, :branch_id)
    end
end