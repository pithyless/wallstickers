require 'spec_helper'

describe 'routes for Pages' do
  it 'routes / to homepage' do
    { :get => '/' }.should route_to('pages#home')
  end
end
