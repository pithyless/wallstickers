class User < ActiveRecord::Base
  concerned_with :authentication, :validation

  has_one :artist
  has_one :cart

  attr_accessible :first_name, :last_name, :password, :password_confirmation

  before_create :build_cart

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.find_by_username_or_email(login)
    return unless login
    if login.include? '@'
      find_by_email(login.downcase)
    else
      find_by_username(login.downcase)
    end
  end

  def to_param #override
    username
  end
end
