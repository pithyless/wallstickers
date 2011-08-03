class User < ActiveRecord::Base
  concerned_with :authentication, :validation

  has_one  :artist
  has_one  :printer
  has_many :orders
  has_many :cart_items, :class_name => 'OrderItem'

  attr_accessible :first_name, :last_name, :password, :password_confirmation

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
end
