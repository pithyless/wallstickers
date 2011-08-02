class ShoppingCartController < ApplicationController
  def shopping_cart
    @items = current_user.cart.items
  end

  def checkout
    # TODO: when can this legitimately fail?
    @order = current_user.cart.checkout_order!

    # TODO: redirect to @order
    redirect_to show_order_progress_path(@order)
  end
end
