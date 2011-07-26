module ApplicationHelper
  def body_classes
    [controller.controller_name]
  end

  def current_user_is?(user)
    return false unless current_user
    current_user.username == user.username
  end

  def current_user_shopping_cart_item_count
    return '0' unless current_user
    return current_user.cart.items.count.to_s
  end
end
