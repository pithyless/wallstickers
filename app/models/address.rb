# -*- coding: utf-8 -*-

class ZipcodeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A\d{2}-\d{3}\z/
      record.errors[attribute] << (options[:message] || "invalid zipcode")
    end
  end
end

class Address < ActiveRecord::Base
  validates :street_line, :presence => true, :length => (3..50)
  validates :city,        :presence => true, :length => (3..50)
  validates :zipcode,     :presence => true, :zipcode => true
end
