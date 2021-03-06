# -*- coding: utf-8 -*-
require 'spec_helper'

describe Wallsticker, 'validates new Wallsticker' do
  it { should validate_presence_of :artist }
  it { should validate_presence_of :title }
  it { should validate_presence_of :permalink }

  it { should ensure_length_of(:title).is_at_least(2).is_at_most(50) }

  it 'should fabricate' do
    sticker = Fabricate(:wallsticker)
    sticker.should be_valid
    sticker.save.should be_true
  end

  describe "uniqueness" do
    before { @sticker = Fabricate(:wallsticker).save! }
    it { should validate_uniqueness_of(:permalink) }
  end
end

describe Wallsticker, 'permalink' do
  before :each do
    username = 'FooBar'
    @artist = Fabricate(:artist, :user => Fabricate(:user, :username => username))
    @sticker = Fabricate(:wallsticker, :artist => @artist, :title => 'Lots of F$""#$% łżó\'źćń cHarS!')
  end

  it 'should paramterize artist and title' do
    @sticker.permalink.should == 'foobar-lots-of-f-lzo-zcn-chars'
  end

  it 'should number duplicate' do
    @sticker = Fabricate(:wallsticker, :artist => @artist, :title => 'Lots of F$""#$% łżó\'źćń cHarS!')
    @sticker.permalink.should == 'foobar-lots-of-f-lzo-zcn-chars--2'
  end

  it 'should correctly number duplicate' do
    sticker = Fabricate(:wallsticker, :artist => @artist, :title => 'Porsche 911')
    @sticker = Fabricate(:wallsticker, :artist => @artist, :title => 'Porsche 911')
    @sticker.permalink.should == 'foobar-porsche-911--2'
  end

  it 'should count third duplicate' do
    @sticker = Fabricate(:wallsticker, :artist => @artist, :title => 'Lots of F$""#$% łżó\'źćń cHarS!')
    @sticker = Fabricate(:wallsticker, :artist => @artist, :title => 'Lots of F$""#$% łżó\'źćń cHarS!')
    @sticker.permalink.should == 'foobar-lots-of-f-lzo-zcn-chars--3'
  end

  it 'should not modify on update' do
    old_title = @sticker.title
    old_permalink = @sticker.permalink
    new_title = 'New title!'
    new_title.should_not == old_title
    @sticker.title = new_title
    @sticker.save!
    @sticker.reload
    @sticker.title.should == new_title
    @sticker.permalink.should == old_permalink
  end
end

describe Wallsticker, 'associations' do
  before :each do
    @artist = Fabricate(:artist)
    @sticker = Fabricate(:wallsticker, :artist => @artist)
  end

  it 'belongs to artist' do
    @sticker.artist.should == @artist
  end
end

describe Wallsticker, 'from and to param' do
  before(:each) do
    artist = Fabricate(:artist, :user => Fabricate(:user, :username => 'jsmith'))
    @wallsticker = Fabricate(:wallsticker, :artist => artist, :title => "Madonna #1 in/not Black & White")
  end

  it { @wallsticker.to_param.should == 'jsmith/madonna-1-in-not-black-white' }

  it 'should find from_param' do
    Wallsticker.from_param('jsmith/madonna-1-in-not-black-white').id.should == @wallsticker.id
    Wallsticker.from_param('jsmith/not-madonna').should be_nil
  end

  it 'should find from_param!' do
    Wallsticker.from_param!('jsmith/madonna-1-in-not-black-white').id.should == @wallsticker.id
    lambda { Wallsticker.from_param!('jsmith/not-madonna') }.should raise_error(ActiveRecord::RecordNotFound)
  end
end

describe Wallsticker, 'authorizations' do
  def allow(user, action, subject)
    Ability.new(user).should be_able_to(action, subject)
  end

  def forbid(user, action, subject)
    Ability.new(user).should_not be_able_to(action, subject)
  end

  before :each do
    @wallsticker = Fabricate :wallsticker
    @guest  = User.new
    @user   = Fabricate :user
    @artist = Fabricate :artist
  end

  it 'anyone to read' do
    allow(@guest, :read, @wallsticker)
  end

  it 'artist can create own' do
    forbid(@guest,  :create, Wallsticker)
    forbid(@user,   :create, Wallsticker)

    w = Wallsticker.new
    forbid(@artist, :create, w)

    w.artist = @artist
    allow(@artist,  :create, w)
  end

  it 'artist can modify own' do
    forbid(@guest,  :update, @wallsticker)
    forbid(@user,   :update, @wallsticker)
    forbid(@artist, :update, @wallsticker)
    allow(@artist,  :update, Fabricate(:wallsticker, :artist => @artist))
  end

  it 'no one can destroy' do
    [@guest, @user, @artist].each do |u|
      forbid(u, :destroy, @wallsticker)
    end
  end
end

describe Wallsticker, 'color' do
  before(:each) do
    @wallsticker = Fabricate(:wallsticker)
  end

  it 'should set hex colors' do
    @wallsticker.colors.should == ["#3b373e", "#b84a72", "#717f99", "#9ab1c7", "#dedfe0"]
    @wallsticker.should be_valid
  end

  it 'should not accept non-hex color' do
    @wallsticker.colors = ['#noreal']
    @wallsticker.should_not be_valid
  end

  it 'should lowercase chars' do
    @wallsticker.colors = ['#Ab2DeF', '#a123b4']
    @wallsticker.valid?
    @wallsticker.save!
    @wallsticker.reload.colors.should == ['#ab2def', '#a123b4']
  end
end
