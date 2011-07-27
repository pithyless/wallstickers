class Cart
  def initialize(user)
    fail "requires a User: #{user.inspect}" unless user.instance_of? User
    @user = user
  end

  def add_item(variant)
    fail "Unrecognized variant #{variant.inspect}" unless variant.instance_of? WallstickerVariant
    @user.cart_items.create!(:wallsticker_variant => variant)
  end

  def items
    @user.cart_items.order('created_at desc')
  end

  def empty?
    size == 0
  end

  def size
    items.count
  end

  def balance_pln
    items.map{ |i| i.price_pln }.sum
  end

  def checkout_order!
    Order.new_order!(@user, items)
  end
end
