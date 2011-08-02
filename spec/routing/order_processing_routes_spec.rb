require 'spec_helper'

describe 'routes for order processing' do
  before :each do
    @order = Fabricate(:order)
    @token = @order.token
  end

  it 'should route GET /order/:id' do
    { :get => "/order/#{@token}" }.should route_to('order_processing#show', :id => @token)
    { :get => show_order_progress_path(@order) }.should route_to('order_processing#show', :id => @token)
  end

  it 'should route POST /cart/:id' do
    { :post => "/order/#{@token}" }.should route_to('order_processing#update', :id => @token)
    { :post => update_order_progress_path(@order) }.should route_to('order_processing#update', :id => @token)
  end
end
