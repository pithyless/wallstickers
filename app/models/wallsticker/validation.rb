class HexColorsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, values)
    if values.blank?
      record.errors[attribute] << (options[:message] || "missing colors")
    else
      values.each do |value|
        unless value =~ /\A#[0-9a-f]{6}\z/
          record.errors[attribute] << (options[:message] || "invalid color: #{value}")
        end
      end
    end
  end
end

class Wallsticker < ActiveRecord::Base
  validates :artist,    :presence => true
  validates :category,  :presence => true
  validates :title,     :presence => true, :length => (2..50)
  validates :permalink, :presence => true, :uniqueness => true, :slug => true
  validates :colors,    :presence => true, :hex_colors => true

  validates_presence_of :source_image
  validates_integrity_of :source_image
  validates_processing_of :source_image

  before_validation :strip_fields
  before_validation :set_permalink, :on => :create

  def strip_fields
    [:title].each { |v| self[v] = (self[v]||'').strip }
  end

  def set_permalink
    return if artist.blank? or title.blank?
    link = "#{artist.username}-#{title}".parameterize
    count = 1
    while Wallsticker.find_by_permalink(link)
      count += 1
      link = "#{artist.username}-#{title}".parameterize + "--#{count}"
    end
    self[:permalink] = link
  end

  def colors=(value)
    write_attribute :colors, value.map { |x| x.downcase }.join(',')
  end

  def colors
    c = read_attribute :colors
    return [] if c.nil?
    c.split(',')
  end
end
