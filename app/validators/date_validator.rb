class DateValidator < ActiveModel::EachValidator
  def validate_each record, attribute, value
    return if value.blank?
    condition = options.keys.first
    comparation_field = options.values.first
    cpm_field_name = record.class.human_attribute_name comparation_field
    case condition
    when :after
      unless value > record.try(comparation_field)
        message = options[:message] || :after
        record.errors.add attribute, message, date: cpm_field_name
      end
    when :after_or_equal_to
      unless value >= record.try(comparation_field)
        message = options[:message] || :after_or_equal_to
        record.errors.add attribute, message, date: cpm_field_name
      end
    end
  end
end
