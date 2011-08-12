require 'spec_helper'

describe Address, 'validates new' do
  it { should validate_presence_of :street_line }
  it { should validate_presence_of :city }
  it { should validate_presence_of :zipcode }

  it 'should validate zipcode format'

  it 'should be valid' do
    @address = Fabricate.build(:address)
    @address.should be_valid
    @address.save.should be_true
  end
end
