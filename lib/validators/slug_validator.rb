class SlugValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A[0-9a-z_+-]+\z/
      record.errors[attribute] << (options[:message] || "invalid slug: #{value}")
    end
  end
end
