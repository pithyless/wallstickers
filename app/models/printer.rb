class Printer < ActiveRecord::Base
  belongs_to :user
  belongs_to :publisher

  validates :user, :presence => true
  validates :publisher, :presence => true

  delegate :username, :to => :user
end
