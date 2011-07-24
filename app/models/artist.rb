class Artist < ActiveRecord::Base
  belongs_to :user
  has_many :wallstickers

  attr_accessible nil

  validates :user, :presence => true

  delegate :username, :full_name, :to => :user

  def self.find_by_username(username)
    user = User.find_by_username(username)
    user.try(:artist)
  end

  def to_param
    username
  end
end
