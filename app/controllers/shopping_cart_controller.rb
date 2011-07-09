class ShoppingCartController < ApplicationController
  def shopping_cart
    @wallsticker_variants = current_user.wallsticker_variants
  end
end
