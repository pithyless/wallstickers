require 'spec_helper'

describe OrderItem, 'validates new OrderItem' do
  it { should validate_presence_of :wallsticker_variant }

  it 'should be valid' do
    item = Fabricate.build(:order_item)
    item.should be_valid
    item.save.should be_true
  end

  it 'should check either user or order' do
    item = Fabricate.build(:order_item)
    item.should be_valid
    item.user = nil
    item.order = nil
    item.should_not be_valid
  end
end

describe OrderItem, 'attributes' do
  it 'should have price'
end
