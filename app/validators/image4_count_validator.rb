class Image4CountValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.size < 4 # valueは子レコードの配列
        record.errors.add(attribute, "needs 4 and more")
    end
  end
end