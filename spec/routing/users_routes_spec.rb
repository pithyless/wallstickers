require 'spec_helper'

describe 'routes for Users' do
  before :each do
    user = Fabricate(:user, :username => 'jsmith')
  end

  it 'routes get /register to new user page' do
    { :get => '/register' }.should route_to('users#new')
    { :get => new_user_path }.should route_to('users#new')
  end

  it 'routes post /register to create user page' do
    { :post => '/register' }.should route_to('users#create')
    { :post => create_user_path }.should route_to('users#create')
  end

  it 'routes /:username/profile to a users profile page' do
    { :get => '/jsmith/profile' }.should route_to('users#profile', :user => 'jsmith')
    { :get => profile_path(user) }.should route_to('users#profile', :user => 'jsmith')
  end

  it 'routes get /:username/profile/edit to a users edit profile page' do
    { :get => '/jsmith/profile/edit' }.should route_to('users#edit', :user => 'jsmith')
    { :get => edit_user_path(user) }.should route_to('users#edit', :user => 'jsmith')
  end

  it 'routes put /:username/profile/edit to an update profile page' do
    { :put => '/jsmith/profile/edit' }.should route_to('users#update', :user => 'jsmith')
    { :put => update_user_path(user) }.should route_to('users#update', :user => 'jsmith')
  end
end