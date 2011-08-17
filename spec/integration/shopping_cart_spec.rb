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
  page.should have_content('Logout')

  page.should have_content('Madonna')
  click_link 'Madonna'
  within '#new_wallsticker_variant' do
    # TODO: choose colors
  end
  click_button 'Add to Cart'
end

describe 'Add item to shopping cart' do
  before :each do
    @artist = Fabricate :artist, :user => Fabricate(:user, :username => 'jsmith')
    @user = Fabricate(:user, :password => 'secret')
    @item = Fabricate :wallsticker, :artist => @artist, :title => 'Madonna'
  end

  it 'cart should initially be empty' do
    visit '/'
    find('#cartsItemCounter').text.should == '0'
  end

  it 'add item from gallery' do
    login_with @user.username, 'secret'
    page.should have_content('Login successfull.')

    3.times do |i|
      add_to_cart

      page.should have_content('Shopping Cart')
      page.should have_content('Madonna')

      find('#cartsItemCounter').text.should == "#{i + 1}"
    end
  end

  it 'should redirect GET request to the item page' do
    get '/jsmith/madonna/order'
    response.should redirect_to("/jsmith/madonna")
  end
end

describe 'Completing Order' do
  before :each do
    @user = Fabricate(:user, :password => 'secret')
    @printer = Fabricate :printer
    @item = Fabricate :wallsticker, :title => 'Madonna'
  end

  def return_to_order_page_as(user)
    order_location = page.current_path
    visit logout_path
    login_with user.username, 'secret'
    visit order_location
  end

  it 'goes through the motions' do
    login_with @user.username, 'secret'

    visit show_wallsticker_path(@item)
    within '#new_wallsticker_variant' do
      # TODO: choose colors
    end
    click_button 'Add to Cart'
    click_button 'Order now!'

    fill_in "order[billing_address_attributes][street_line]", :with => 'ul Pawia 24 / 4a'
    fill_in "order[billing_address_attributes][zipcode]",     :with => '12-345'
    fill_in "order[billing_address_attributes][city]",        :with => 'Warszawa'

    # TODO: make 2 separate tests (w/ and w/o shipping_address)
    fill_in "order[shipping_address_attributes][street_line]", :with => 'ul Pawia 24 / 4a'
    fill_in "order[shipping_address_attributes][zipcode]",     :with => '12-345'
    fill_in "order[shipping_address_attributes][city]",        :with => 'Warszawa'
    click_button 'Confirm Address'

    click_button 'Let me pay!'

    page.should have_content('Order Status: Waiting acceptance by printer')
    page.should_not have_content('Accept print order')

    return_to_order_page_as(@printer)
    page.should have_content('Order Status: Waiting acceptance by printer')
    page.should have_button('Accept print order')

    click_button 'Accept print order'

    return_to_order_page_as(@user)
    page.should have_content('Order Status: Waiting complete printing')
    page.should_not have_content('Printing complete!')

    return_to_order_page_as(@printer)
    # TODO: page.should have_link?("Download source image", :href => 'http://www.google.com')
    page.should have_content('Order Status: Waiting complete printing')
    page.should have_button('Printing complete!')

    click_button 'Printing complete!'

    return_to_order_page_as(@user)
    page.should have_content('Order Status: Waiting shipping package')
    page.should_not have_content('Package shipped!')

    return_to_order_page_as(@printer)
    page.should have_content('Order Status: Waiting shipping package')
    page.should have_button('Package shipped!')

    click_button 'Package shipped!'

    return_to_order_page_as(@user)
    page.should have_content('This order was successfully completed and shipped.')

    return_to_order_page_as(@printer)
    page.should have_content('This order was successfully completed and shipped.')
  end
end
