require 'spec_helper'

describe ShoppingCartController do
  render_views

  it 'needs to test the shopping cart'

  describe 'checkout' do
    it 'redirects successful checkout to order' do
      variant = Fabricate :wallsticker_variant
      user = Fabricate :user
      login_user user
      user.cart.add_item(variant)

      post 'checkout'
      user.orders.count.should == 1
      request.should redirect_to(show_order_progress_path(user.orders.first))
    end
  end
end
