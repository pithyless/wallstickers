require 'spec_helper'

describe CategoriesController do
  before :each do
    @category = Category.create!(:name => 'BeeBop', :slug => 'beebop')
  end

  it "should browse" do
    get 'browse', :id => 'beebop'
    response.should be_success
  end

  it 'should test showing correct wallstickers from category'
end
