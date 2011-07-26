require 'spec_helper'

describe UserSessionsController do
  before(:each) do
    @user = Fabricate(:user, :password => 'secret')
  end

  def login_with(username, password)
    visit '/'
    within("#session") do
      fill_in 'username', :with => username
      fill_in 'password', :with => password
    end
    click_button 'Login'
  end

  it "should login with username" do
    login_with @user.username, 'secret'
    page.should have_content('Login successfull.')
  end

  it "should login with email" do
    login_with @user.email, 'secret'
    page.should have_content('Login successfull.')
  end

  it "should not login bad username" do
    login_with 'notreal', 'secret'
    page.should have_content('Login failed.')
  end

  it "should not login bad email" do
    login_with 'notreal@google.com', 'secret'
    page.should have_content('Login failed.')
  end

  it "should not login username / bad password" do
    login_with @user.username, 'fakepass'
    page.should have_content('Login failed.')
  end

  it "should not login email / bad password" do
    login_with @user.username, 'fakepass'
    page.should have_content('Login failed.')
  end

  it "should logout user" do
    login_with @user.username, 'secret'
    page.should have_content('Login successfull.')
    click_link I18n.t('layouts.user.logout')
    page.should have_content('Logged out!')
  end
end
