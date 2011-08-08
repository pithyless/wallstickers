require 'spec_helper'

def login_with(username, password)
  visit '/'
  within("#session") do
    fill_in 'username', :with => username
    fill_in 'password', :with => password
  end
  click_button 'Login'
end

describe 'Correct permissions' do
  before :each do
    @artist = Fabricate :artist, :user => Fabricate(:user, :username => 'jsmith')
  end

  it 'should only allow adding if owner of gallery'
end

describe 'Upload new wallsticker' do
  before :each do
    @artist = Fabricate :artist, :user => Fabricate(:user, :username => 'jsmith')
  end

  it 'creates new wallsticker' do
    login_with 'jsmith', 'secret'
    visit '/jsmith/new'
    page.should have_content('Upload new wallsticker')

    images_path = File.join(Rails.root, 'spec', 'support', 'images')

    within('#new_wallsticker') do
      fill_in 'wallsticker[title]', :with => 'Kickass Decal'
      fill_in 'wallsticker[description]', :with => 'Super-duper history of decal in the making!'
      attach_file 'wallsticker[source_image]', File.join(images_path, 'wallstickers', 'strus.png')
      attach_file 'wallsticker[sale_photos_attributes][0][image]', File.join(images_path, 'sales', 'trip2_product_1.jpg')
      attach_file 'wallsticker[sale_photos_attributes][1][image]', File.join(images_path, 'sales', 'trip2_product_1.jpg')
    end
    click_button 'Create Wallsticker'

    page.current_path.should == '/jsmith/kickass-decal'
    page.should have_content('Kickass Decal')
    page.should have_content('Super-duper history of decal in the making!')
  end
end
