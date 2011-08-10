class Category < ActiveRecord::Base
  validates :slug, :presence => :true, :uniqueness => :true, :length => (2..30), :slug => :true
  validates :name, :presence => :true, :length => (2..30)

  before_validation :generate_slug, :on => :create

  attr_accessible :slug, :name

  def generate_slug
    return if name.blank?
    self[:slug] = name.parameterize
  end
end
