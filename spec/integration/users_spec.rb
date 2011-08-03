require 'spec_helper'

def login_with(username, password)
  visit '/'
  within("#session") do
    fill_in 'username', :with => username
    fill_in 'password', :with => password
  end
  click_button 'Login'
end

describe "Registering" do
  visit new_user_path
  within '#contentBox' do
    fill_in 'username', :with => "foobar"
    fill_in 'email', :with => "foobar@example.com"
    fill_in 'first_name', :with => "Foo"
    fill_in 'last_name', :with => "Bar"
    fill_in 'password', :with => "rumpus"
    fill_in 'password_confirmation', :with => "rumpus"
  end
  click_button 'Commit'
  page.should have_content('User was successfully created.')

  logout_user

  login_with("foobar", "rumpus")
  page.should have_content('Login successfull.')
end
