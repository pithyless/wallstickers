class Artist < ActiveRecord::Base
  belongs_to :user
  has_many :wallstickers

  attr_accessible nil

  validates :user, :presence => true

  delegate :username, :to => :user
end
