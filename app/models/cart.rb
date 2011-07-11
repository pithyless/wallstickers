class Cart < ActiveRecord::Base
  belongs_to :user
  has_many   :items, :class_name => 'CartItem'

  validates :user, :presence => true

  attr_accessible nil
end
