class User < ActiveRecord::Base
  concerned_with :authentication, :validation

  has_one :artist
  has_many :wallsticker_variants, :foreign_key => 'buyer_id'

  attr_accessible :first_name, :last_name, :password, :password_confirmation

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
end
