require 'spec_helper'

describe 'routes for shopping cart' do
  it 'should route /cart to shopping cart' do
    { :get => '/cart' }.should route_to('shopping_cart#shopping_cart')
    { :get => shopping_cart_path }.should route_to('shopping_cart#shopping_cart')
  end

  it 'should route /cart/checkout' do
    { :post => '/cart/checkout' }.should route_to('shopping_cart#checkout')
    { :post => shopping_cart_checkout_path }.should route_to('shopping_cart#checkout')
  end
end
