require 'spec_helper'

describe 'routes for order processing' do
  before :each do
    @order = Fabricate(:order, :id => 123)
  end

  it 'should route GET /order/:id' do
    { :get => '/order/123' }.should route_to('order_processing#show', :id => '123')
    { :get => show_order_progress_path(@order) }.should route_to('order_processing#show', :id => '123')
  end

  it 'should route POST /cart/:id' do
    { :post => '/order/123' }.should route_to('order_processing#update', :id => '123')
    { :post => update_order_progress_path(@order) }.should route_to('order_processing#update', :id => '123')
  end
end
