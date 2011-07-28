# -*- coding: utf-8 -*-
class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}\z/
      record.errors[attribute] << (options[:message] || "invalid email")
    end
  end
end

class UsernameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A[a-z0-9]+\z/
      record.errors[attribute] << (options[:message] || "invalid username")
    end
  end
end

class User < ActiveRecord::Base
  RESERVED_USERNAMES = ['all', 'admin', 'info', 'wallstickers']

  attr_accessor :password

  validates :username, :presence => true, :uniqueness => true, :length => (3..20),
                       :exclusion => RESERVED_USERNAMES, :username => true

  validates :email, :presence => true, :uniqueness => true, :length => (6..100), :email => true
  validates :first_name, :presence => true, :length => (2..40)
  validates :last_name,  :presence => true, :length => (2..40)

  validates :password, :on => :create, :presence => true, :length => (3..60), :confirmation => true

  before_validation :strip_fields

  def strip_fields
    [:username, :email, :first_name, :last_name].each {|v| self[v] = (self[v]||'').strip }
  end

  def username=(value)
    write_attribute :username, value.try(:downcase)
  end

  def email=(value)
    write_attribute :email, value.try(:downcase)
  end
end
