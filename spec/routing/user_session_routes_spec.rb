require 'spec_helper'

describe 'routes for UserSessions' do
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

  it 'should route get /register to new user page' do
    { :get => '/register' }.should route_to('profiles#new')
    { :get => register_user_path }.should route_to('profiles#new')
  end

  it 'should route post /register to create user page' do
    { :post => '/register' }.should route_to('profiles#create')
    { :post => create_user_path }.should route_to('profiles#create')
  end

  it 'should route artist profile edit' do
    @user = Fabricate(:user, :username => 'xyz')
    { :get => '/profile/xyz/edit' }.should route_to('profiles#edit', :id => 'xyz')
    { :get => edit_profile_path(@user) }.should route_to('profiles#edit', :id => 'xyz')
  end

  it 'should route artist profile update' do
    @user = Fabricate(:user, :username => 'xyz')
    { :put => '/profile/xyz/edit' }.should route_to('profiles#update', :id => 'xyz')
    { :put => update_profile_path(@user) }.should route_to('profiles#update', :id => 'xyz')
  end
end
