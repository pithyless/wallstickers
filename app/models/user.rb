class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :password, :password_confirmation

  def self.find_by_username_or_email(login)
    return unless login
    if login.include? '@'
      find_by_email(login.downcase)
    else
      find_by_username(login.downcase)
    end
  end
end
