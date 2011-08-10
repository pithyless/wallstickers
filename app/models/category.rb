class Category < ActiveRecord::Base
  has_many :wallstickers

  attr_accessible :slug, :name

  validates :slug, :presence => :true, :uniqueness => :true, :length => (2..30), :slug => :true
  validates :name, :presence => :true, :length => (2..30)

  before_validation :generate_slug, :on => :create

  def generate_slug
    return if name.blank?
    self[:slug] = name.parameterize
  end

  def to_param
    slug
  end
end
