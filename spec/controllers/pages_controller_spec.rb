require 'spec_helper'

describe PagesController do
  render_views

  def page
    Capybara::Node::Simple.new(@response.body)
  end

  it 'should find home' do
    get 'home'
    response.should be_success

    page.should have_content('Inspirations')
  end
end
