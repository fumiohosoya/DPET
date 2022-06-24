module EvaluatesHelper
    
    def timecount_hm(datetime)
        
        if (datetime == nil)
            return ""
        else
            mm, ss = datetime.to_i.divmod(60)
            hh, mm = mm.divmod(60)
            return "%02d:%02d" % [hh, mm]
        end
    end
end
