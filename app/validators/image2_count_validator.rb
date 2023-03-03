class Image2CountValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.size < 2 # valueは子レコードの配列
        record.errors.add(attribute, "needs 2 and more")
    end
  end
end