class Cart < ActiveRecord::Base
  belongs_to :user

  validates :user, :presence => true

  attr_accessible nil
end
