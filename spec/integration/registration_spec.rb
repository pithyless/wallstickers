require 'spec_helper'

def login_with(username, password)
  visit '/'
  within("#session") do
    fill_in 'username', :with => username
    fill_in 'password', :with => password
  end
  click_button 'Login'
end

describe "User registration" do
  it 'Registers user' do
    visit '/register'

    within '#new_user' do
      fill_in 'user[email]', :with => "foobar@example.com"
      fill_in 'user[first_name]', :with => "Foo"
      fill_in 'user[last_name]', :with => "Bar"
      fill_in 'user[password]', :with => "secret"
      fill_in 'user[password_confirmation]', :with => "secret"
    end
    click_button 'Register'
    page.should have_content('Registration complete.')

    login_with("foobar@example.com", "secret")
    page.should have_content('Login successfull.')
  end
end
