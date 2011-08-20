require 'spec_helper'

describe 'routes for Pages' do
  it 'routes / to homepage' do
    { :get => '/' }.should route_to('pages#home')
  end

  it 'routes about to about us page' do
    { :get => 'about' }.should route_to('pages#about')
  end

  it 'routes contact to contact us page' do
    { :get => 'contact' }.should route_to('pages#contact')
  end

  it 'routes delivery to delivery page' do
    { :get => 'delivery' }.should route_to('pages#delivery')
  end

  it 'routes how_to to how to page' do
    { :get => 'how_to' }.should route_to('pages#how_to')
  end

  it 'routes lost to lost packages page' do
    { :get => 'lost' }.should route_to('pages#lost')
  end

  it 'routes privacy to privacy policy page' do
    { :get => 'privacy' }.should route_to('pages#privacy')
  end

  it 'routes returns to returns page' do
    { :get => 'returns' }.should route_to('pages#returns')
  end

  it 'routes rules to rules page' do
    { :get => 'rules' }.should route_to('pages#rules')
  end
end
