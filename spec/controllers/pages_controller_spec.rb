require 'spec_helper'

describe PagesController do
  it 'should find home' do
    get 'home'
    response.should be_success
  end
end
