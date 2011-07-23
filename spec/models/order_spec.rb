require 'spec_helper'

describe Order, 'validates brand new Order' do
  it { should validate_presence_of :user }
  it { should validate_presence_of :state }

  it { should validate_presence_of :balance_pln }
  it { should validate_numericality_of :balance_pln }

  it 'should be valid' do
    order = Fabricate.build(:order)
    order.should be_valid
    order.save.should be_true
  end
end

describe Order, 'initial states' do
  before :each do
    @order = Fabricate(:order)
  end

  it 'should have initial states' do
    @order.state_name.should          == :waiting_confirm_address_info
  end
end
