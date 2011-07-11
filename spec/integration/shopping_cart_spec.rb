require 'spec_helper'

describe 'Add item to shopping cart' do
  before :each do
    @artist = Fabricate :artist
    @user = Fabricate(:user, :password => 'secret')
    @item   = Fabricate :wallsticker, :artist => @artist, :title => 'Madonna'
  end
  
  def login_with(username, password)
    visit '/login'
    within("#session") do
      fill_in 'Username', :with => username
      fill_in 'Password', :with => password
    end
    click_button 'Login'
  end

  it 'add item from gallery' do
    login_with @user.username, 'secret'
    page.should have_content('Login successfull.')

    visit "/gallery/#{@artist.username}"
    page.should have_content('Logout')

    page.should have_content('Madonna')
    click_link 'Madonna'
    within '#new_wallsticker_variant' do
      fill_in 'Color', :with => 'e3e3e3'
    end
    click_button 'Create Wallsticker variant'

    page.should have_content('Shopping Cart')
    page.should have_content('Madonna')
  end
end
