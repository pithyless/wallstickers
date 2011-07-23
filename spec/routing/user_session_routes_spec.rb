require 'spec_helper'

describe 'routes for UserSessions' do
  it 'should route /login' do
    { :get => '/login' }.should route_to('user_sessions#new')
    { :get => login_path }.should route_to('user_sessions#new')
  end

  it 'should route /logout' do
    { :get => '/logout' }.should route_to('user_sessions#destroy')
    { :get => logout_path }.should route_to('user_sessions#destroy')
  end

  it 'should route user_session#create' do
    { :post => '/user_sessions' }.should route_to('user_sessions#create')

    # TODO: this will now be routable to wallstickers#gallery;
    #       requires test to make sure it will always be 404
    # { :get  => '/user_sessions' }.should_not be_routable
  end
end
