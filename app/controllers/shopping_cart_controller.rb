class ShoppingCartController < ApplicationController
  def shopping_cart
    @items = current_user.cart.items
  end
end
