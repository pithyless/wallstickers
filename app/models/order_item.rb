class OrderItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  belongs_to :wallsticker_variant

  attr_accessible :wallsticker_variant

  validate  :order_or_user_valid
  validates :wallsticker_variant, :presence => true

  def variant
    wallsticker_variant
  end

  def price_pln
    variant.price_pln
  end

  def order_or_user_valid
    unless (user.nil? && order.present?) or (user.present? && order.nil?)
      errors.add(:user, 'User or Order must be present.')
      errors.add(:order, 'User or Order must be present.')
    end
  end
end
