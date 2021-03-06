require 'spec_helper'

describe Artist, 'validations' do
  it { should validate_presence_of :user }

  it 'should fabricate' do
    artist = Fabricate(:artist)
    artist.should be_valid
    artist.save.should be_true
  end
end

describe Artist, 'associations' do
  before :each do
    @user = Fabricate(:user)
    @artist = Fabricate(:artist, :user => @user)
  end

  it 'should have User' do
    @artist.user.should == @user
  end

  it 'should be accessible via User' do
    @user.artist.should == @artist
  end
end

describe Artist, 'attributes' do
  before :each do
    @artist = Fabricate :artist
    @user = Fabricate :user
  end

  it { @artist.to_param.should == @artist.user.username }

  it 'should find_by_username' do
    Artist.find_by_username(@artist.username).should == @artist
    Artist.find_by_username('NotRealUser').should be_nil
  end

  it 'should find_by_username!' do
    Artist.find_by_username!(@artist.username).should == @artist
    lambda { Artist.find_by_username!('NotRealUser') }.should raise_error(ActiveRecord::RecordNotFound)
  end
end

describe Artist, 'balance' do
  before :each do
    @artist = Fabricate(:artist)
  end

  it 'should default to 0' do
    @artist.balance.should == 0
  end

  it 'should not mass assign' do
    @artist.update_attributes(:balance => 5)
    @artist.reload
    @artist.balance.should == 0
  end
end

describe Artist, 'wallstickers' do
  before :each do
    @artist = Fabricate(:artist)
    @sticker = Fabricate(:wallsticker, :artist => @artist)
  end

  it 'owns wallsticker' do
    @artist.wallstickers.should == [@sticker]
  end

  it 'owns many wallstickers' do
    sticker2 = Fabricate(:wallsticker, :artist => @artist)
    sticker2.save!
    @artist.wallstickers.order('created_at desc').all.should == [sticker2, @sticker]
  end
end
