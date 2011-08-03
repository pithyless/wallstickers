require 'spec_helper'

describe 'routes for Users' do
  before :each do
    user = Fabricate(:user, :username => 'jsmith')
  end

  it 'routes /register to new user page' do
    { :get => '/register' }.should route_to('users#new')
    { :get => new_user_path }.should route_to('users#new')
    #TODO post routes
  end

  it 'routes /:username/profile to a users profile page' do
    { :get => '/jsmith/profile' }.should route_to('users#profile', :user => 'jsmith')
    { :get => profile_path(user) }.should route_to('users#profile', :user => 'jsmith')
  end

  it 'routes /:username/profile/edit to a users edit profile page' do
    { :get => '/jsmith/profile/edit' }.should route_to('users#edit', :user => 'jsmith')
    { :get => edit_user_path(user) }.should route_to('users#edit', :user => 'jsmith')
    #TODO put routes
  end
end