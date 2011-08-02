require 'spec_helper'

describe 'routes for Wallstickers' do
  before :each do
    user = Fabricate(:user, :username => 'jsmith')
    artist = Fabricate(:artist, :user => user)
    @wallsticker = Fabricate(:wallsticker, :artist => artist, :title => 'Madonna in Black')
  end

  it 'routes /:username to artist gallery' do
    { :get => '/jsmith' }.should route_to('wallstickers#gallery', :artist => 'jsmith')
    { :get => artist_gallery_path('jsmith') }.should route_to('wallstickers#gallery', :artist => 'jsmith')
  end

  it 'routes /:username/new to upload new wallsticker for specific artist' do
    { :get => '/jsmith/new' }.should route_to('wallstickers#new', :artist => 'jsmith')
    { :get => new_wallsticker_path('jsmith') }.should route_to('wallstickers#new', :artist => 'jsmith')
  end

  it 'routes /:username/new to save a new wallsticker in the database' do
    { :post => '/jsmith/new' }.should route_to('wallstickers#create', :artist => 'jsmith')
    { :post => create_wallsticker_path('jsmith') }.should route_to('wallstickers#create', :artist => 'jsmith')
  end

  it 'routes /:username/:item to wallstickers#show' do
    { :get => '/jsmith/madonna-in-black'
    }.should route_to('wallstickers#show', :artist_title => 'jsmith/madonna-in-black')

    { :get => show_wallsticker_path('jsmith/madonna-in-black')
    }.should route_to('wallstickers#show', :artist_title => 'jsmith/madonna-in-black')

    { :get => show_wallsticker_path(@wallsticker)
    }.should route_to('wallstickers#show', :artist_title => 'jsmith/madonna-in-black')
  end

  it 'routes /:username/:item/order to wallstickers#add_to_cart' do
    { :post => '/jsmith/madonna-in-black/order'
    }.should route_to('wallstickers#add_to_cart', :artist_title => 'jsmith/madonna-in-black')

    { :post => add_wallsticker_to_cart_path('jsmith/madonna-in-black')
    }.should route_to('wallstickers#add_to_cart', :artist_title => 'jsmith/madonna-in-black')

    { :post => add_wallsticker_to_cart_path(@wallsticker)
    }.should route_to('wallstickers#add_to_cart', :artist_title => 'jsmith/madonna-in-black')

    { :get  => '/jsmith/madonna-in-black/order' }.should_not be_routable
  end
end
