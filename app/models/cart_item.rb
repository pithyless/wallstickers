class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :wallsticker_variant

  attr_accessible :wallsticker_variant

  validates :cart, :presence => true
  validates :wallsticker_variant, :presence => true

  def variant
    wallsticker_variant
  end

  def price_pln
    variant.price_pln
  end
end
