class Artist < ActiveRecord::Base
  belongs_to :user

  attr_accessible nil

  validates :user, :presence => true
end
