require 'spec_helper'

def login_with(username, password)
  visit '/'
  within("#session") do
    fill_in 'username', :with => username
    fill_in 'password', :with => password
  end
  click_button 'Login'
end

def add_to_cart
  visit "/#{@artist.username}"
  page.should have_content(I18n.t 'layouts.user.logout')

  page.should have_content('Madonna')
  click_link 'Madonna'
  within '#new_wallsticker_variant' do
    fill_in 'Color', :with => 'e3e3e3'
  end
  click_button 'Create Wallsticker variant'
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

    10.times do |i|
      add_to_cart

      page.should have_content(I18n.t 'shopping_cart.title')
      page.should have_content('Madonna')

      find('#cartsItemCounter').text.should == "#{i + 1}"
    end
  end
end
