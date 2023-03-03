class Image3CountValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.size < 3 # valueは子レコードの配列
        record.errors.add(attribute, "needs 3 and more")
    end
  end
end