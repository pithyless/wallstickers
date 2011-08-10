require 'spec_helper'

describe Category, 'validates new' do
  it { should validate_presence_of :name }
  it { should validate_presence_of :slug }

  it 'should fabricate' do
    category = Fabricate(:category)
    category.should be_valid
    category.save.should be_true
  end

  describe "uniqueness" do
    before { @category = Fabricate(:category).save! }
    it { should validate_uniqueness_of(:slug) }
  end
end

describe Category, 'slug' do
  before :each do
    @category = Fabricate(:category, :name => 'Foo b$ar ba+z...')
  end

  it { @category.slug.should == 'foo-b-ar-ba-z' }
end
