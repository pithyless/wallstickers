# -*- coding: utf-8 -*-
require 'spec_helper'

describe User, 'validates new User' do
  it { should validate_presence_of :username }
  it { should ensure_length_of(:username).is_at_least(3).is_at_most(20) }

  it { should validate_presence_of :email }
  it { should ensure_length_of(:email).is_at_least(6).is_at_most(100) }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should ensure_length_of(:first_name).is_at_least(2).is_at_most(40) }
  it { should ensure_length_of(:last_name).is_at_least(2).is_at_most(40) }

  it 'should be valid' do
    @user = Fabricate.build(:user)
    @user.should be_valid
    @user.save.should be_true
  end

  describe "uniqueness" do
    before { @user = Fabricate(:user).save! }
    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:email) }
  end
end

describe User, 'making fields idiot-proof' do
  before { @user = Fabricate.build(:user) }

  it 'should restrict usernames' do
    ['all', 'admin', 'info', 'wallstickers'].each do |u|
      @user.username = u
      @user.should_not be_valid
    end
  end

  it 'should disallow silly usernames' do
    %w{ % @ ? ! . + - _ / \ | ó ł ń ż }.each do |u|
      @user.username = "foo#{u}bar"
      @user.should_not be_valid, "#{@user.username}"
    end
  end

  it 'should lowercase username' do
    @user.username = 'likeOMGlolZ'
    @user.save!
    @user.reload.username.should == 'likeomglolz'
  end

  it 'should lowercase email' do
    @user.email = 'likeOMG@lolZ.cOm'
    @user.save!
    @user.reload.email.should == 'likeomg@lolz.com'
  end

  it 'should validate email format' do
    ['foo', 'foo@bar', 'a@b.c'].each do |email|
      @user.email = email
      @user.should_not be_valid
    end
  end

  it 'should strip fields' do
    @user.username = '  foo '
    @user.email = '  foo@bar.com  '
    @user.should be_valid
    @user.save!
    @user.reload
    @user.username.should == 'foo'
    @user.email.should == 'foo@bar.com'
  end
end

describe User, 'callbacks on create' do
  before { @user = Fabricate.build(:user) }

  it 'should require a password' do
    ['', '    ', nil].each do |pass|
      @user.password = pass
      @user.should_not be_valid
    end
  end

  it 'should not require password on update' do
    @user.save!
    old_pass = @user.crypted_password
    @user.password = nil
    @user.should be_valid
    @user.save.should be_true
    @user.reload.crypted_password.should == old_pass
  end
end

describe User, 'authentication' do
  before do
    @login = 'swordfish'
    @email = 'sword@fish.com'
    @password = 'nightingale'
    Fabricate(:user, :username => @login, :email => @email, :first_name => 'first',
                     :last_name => 'last', :password => @password)
    @user = User.find_by_username(@login)
  end

  it 'should find user' do
    @user.email.should == @email
    @user.username.should == @login
    @user.first_name = 'firs'
    @user.last_name  = 'last'
  end

  it "should return the user object for a valid login using his username" do
    User.authenticate(@login, @password).should == @user
    User.authenticate(@login.upcase, @password).should == @user
  end

  it "should return the user object for a valid login using his email" do
    User.authenticate(@email, @password).should == @user
    User.authenticate(@email.upcase, @password).should == @user
  end

  it "should return nil for incorrect login attempts" do
    User.authenticate(@login, "bad_password").should be_nil
    User.authenticate(@email, "bad_password").should be_nil
    User.authenticate("bad_email", "badpass").should be_nil
    User.authenticate("", "").should be_nil
    User.authenticate(nil, nil).should be_nil
  end
end

describe User, 'attributes' do
  before { @user = Fabricate(:user, :first_name => 'Steven', :last_name => 'Seagal') }

  it 'should show fullname' do
    @user.full_name.should == 'Steven Seagal'
  end
end
