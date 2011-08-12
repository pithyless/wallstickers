class Artist < ActiveRecord::Base
  belongs_to :user
  has_many :wallstickers

  mount_uploader :avatar, ArtistAvatarUploader

  attr_accessible :avatar, :bio

  validates :user, :presence => true

  delegate :username, :full_name, :to => :user

  def self.find_by_username(username)
    user = User.find_by_username(username)
    user.try(:artist)
  end

  def self.find_by_username!(username)
    User.find_by_username!(username).artist
  end

  def to_param
    username
  end
end
