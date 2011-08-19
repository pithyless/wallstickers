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

  it 'should route artist profile edit' do
    @artist = Fabricate :artist, :user => Fabricate(:user, :username => 'xyz')
    { :get => '/profile/xyz/edit' }.should route_to('profiles#edit', :id => 'xyz')
    { :get => edit_artist_profile_path(@artist) }.should route_to('profiles#edit', :id => 'xyz')
  end
end
