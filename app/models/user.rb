class User < ActiveRecord::Base
  concerned_with :authentication, :validation

  has_one  :artist
  has_one  :printer
  has_many :orders
  has_many :cart_items, :class_name => 'OrderItem'

  accepts_nested_attributes_for :artist
  attr_accessible :first_name, :last_name, :password, :password_confirmation, :artist_attributes

  def to_param
    self.username
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def cart
    @cart ||= Cart.new(self)
  end

  def artist
    @artist ||= Artist.find_by_user_id(self.id)
  end

  def artist?
    !!artist
  end

  def printer
    @printer ||= Printer.find_by_user_id(self.id)
  end

  def printer?
    !!printer
  end

  def guest?
    new_record?
  end

  ## Finders
  def self.find_by_username_or_email(login)
    return unless login
    if login.include? '@'
      find_by_email(login.downcase)
    else
      find_by_username(login.downcase)
    end
  end

  ## Helpers
  def self.generate_unique_username
    token = ''
    while token.blank? or self.find_by_username(token)
      token = (Random.rand * (10**9)).floor.to_s while token.length < 8
    end
    token[0..7]
  end
end
