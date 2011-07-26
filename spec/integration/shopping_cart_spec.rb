require 'spec_helper'

def login_with(username, password)
  visit '/'
  within("#session") do
    fill_in 'username', :with => username
    fill_in 'password', :with => password
  end
  click_button 'Login'
end

describe 'Add item to shopping cart' do
  before :each do
    @artist = Fabricate :artist
    @user = Fabricate(:user, :password => 'secret')
    @item   = Fabricate :wallsticker, :artist => @artist, :title => 'Madonna'
  end

  it 'cart should initially be empty' do
    visit '/'
    find('#cartsItemCounter').text.should == '0'
  end

  it 'add item from gallery' do
    login_with @user.username, 'secret'
    page.should have_content('Login successfull.')

    visit "/#{@artist.username}"
    page.should have_content(I18n.t 'layouts.user.logout')

    page.should have_content('Madonna')
    click_link 'Madonna'
    within '#new_wallsticker_variant' do
      fill_in 'Color', :with => 'e3e3e3'
    end
    click_button 'Create Wallsticker variant'

    page.should have_content('Shopping Cart')
    page.should have_content('Madonna')

    find('#cartsItemCounter').text.should == '1'
  end
end
