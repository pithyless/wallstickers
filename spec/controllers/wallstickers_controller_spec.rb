require 'spec_helper'

describe WallstickersController do
  it 'should test index'
  it 'should test gallery'
  it 'should test show'
end

describe WallstickersController, '#new' do
  before(:each) do
    @artist = Fabricate(:artist)
    @user  = Fabricate(:user)
  end

  it 'should redirect to login for guest' do
    get 'new'
    response.should redirect_to(login_path)
  end

  it 'should redirect to artist_register for normal user' do
    login_user @user
    lambda { get 'new' }.should raise_error('Not Found')
    # TODO: should redirect to artist_register
  end

  it 'should show new wallsticker page for artist' do
    login_user @artist.user
    get 'new'
    response.should be_success
  end

  it "should upload new wallsticker to artist's gallery"
end

describe WallstickersController, '#show' do
  before(:each) do
    @artist = Fabricate(:artist)
    @user = Fabricate(:user)
    @item = Fabricate(:wallsticker, :artist => @artist, :title => "title")
  end

  it "should show a wallsticker page given an existing artist-wallsticker pair" do
    login_user @artist.user
    @item.url_path
    response.should be_success
  end

end