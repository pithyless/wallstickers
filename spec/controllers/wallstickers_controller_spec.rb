require 'spec_helper'

describe WallstickersController do
  it 'should test index'
  it 'should test gallery'
  it 'should test show'
end

describe WallstickersController, 'named routes' do
  before :each do
    @artist = Fabricate(:artist, :user => Fabricate(:user, :username => 'jsmith'))
    @wallsticker = Fabricate(:wallsticker, :artist => @artist, :title => "Madonna in Black")
  end

  it { artist_gallery_path(@artist).should               == '/jsmith' }
  it { new_wallsticker_path(@artist).should              == '/jsmith/new' }
  it { show_wallsticker_path(@wallsticker).should        == '/jsmith/madonna-in-black' }
  it { add_wallsticker_to_cart_path(@wallsticker).should == '/jsmith/madonna-in-black/order' }
end

describe WallstickersController, '#new' do
  render_views

  before(:each) do
    @artist = Fabricate(:artist)
    @user  = Fabricate(:user)
  end

  it 'should redirect to login for guest' do
    get 'new', :artist => @artist
    flash[:notice].should == 'Login required.'
    response.should redirect_to('/')
  end

  it 'should show new wallsticker page for artist' do
    login_user @artist.user
    get 'new', :artist => @artist.to_param
    response.should be_success
  end

  it 'should forbid normal users' do
    login_user @user
    get 'new', :artist => @artist.to_param
    response.status.should be(403)
  end

  it "should forbid other artist's gallery" do
    login_user @artist.user
    get 'new', :artist => Fabricate(:artist).to_param
    response.status.should be(403)
  end

  it "should upload new wallsticker to artist's gallery"
end

describe WallstickersController, 'views' do
  render_views

  before(:each) do
    @artist = Fabricate(:artist, :user => Fabricate(:user, :username => 'jsmith'))
    @wallsticker = Fabricate(:wallsticker, :artist => @artist, :title => "Madonna in Black")
  end

  describe '#show' do
    it "should show the wallsticker page" do
      get 'show', :artist_title => @wallsticker.to_param
      response.should be_success
    end
  end

  describe '#gallery' do
    it "should show the gallery" do
      get 'gallery', :artist => 'jsmith'
      response.should be_success
      response.should render_template('wallstickers/gallery')
    end
  end

  describe '#add_to_cart' do
    it 'should test POST adds order to shopping cart'
  end
end
