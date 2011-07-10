class HexColorValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A[0-9A-F]{6}\z/
      record.errors[attribute] << (options[:message] || "invalid color: #{value} baz")
    end
  end
end

class WallstickerVariant < ActiveRecord::Base
  validates :wallsticker, :presence => true
  validates :buyer,       :presence => true
  validates :color,       :presence => true, :hex_color => true
  validates :width_cm,    :presence => true
  validates :height_cm,   :presence => true
  validates :price_pln,   :presence => true

  def color=(value)
    write_attribute :color, value.try(:upcase)
  end
end
