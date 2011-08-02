class SlugValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A[a-z0-9-]+\z/
      record.errors[attribute] << (options[:message] || "invalid slug")
    end
  end
end

class Publisher < ActiveRecord::Base
  has_many :printers

  validates :slug, :presence => true, :uniqueness => true, :slug => true
  validates :name, :presence => true

  before_validation :strip_fields
  before_validation :set_slug, :on => :create

  def strip_fields
    [:name].each {|v| self[v] = (self[v]||'').strip }
  end

  def set_slug
    return if slug.present? or name.blank?
    slug = name.parameterize
    count = 1
    while Publisher.find_by_slug(slug)
      count += 1
      slug = name.parameterize + "--#{count}"
    end
    self[:slug] = slug
  end
end
