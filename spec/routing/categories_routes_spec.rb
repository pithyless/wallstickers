require 'spec_helper'

describe 'routes for Categories' do
  it 'routes /browse/kitchen' do
    { :get => '/browse/kitchen'
      }.should route_to('categories#browse', :id => 'kitchen')
    { :get => browse_category_path(Category.find_by_slug!('kitchen'))
      }.should route_to('categories#browse', :id => 'kitchen')
  end
end
