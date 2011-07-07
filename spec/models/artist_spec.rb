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
