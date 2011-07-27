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

describe OrderItem, 'Wallsticker Variant' do
  before :each do
    @user  = Fabricate(:user)
    @variant = Fabricate(:wallsticker_variant, :width_cm => 50, :height_cm => 120, :price_pln => 20)
    @item = @user.cart.add_item(@variant)
  end

  it 'should be wallsticker variant' do
    @item.variant.should_not be_nil
    @item.variant.should be_an_instance_of(WallstickerVariant)
  end

  it 'should have width' do
    @item.variant.width_cm.should == 50
  end

  it 'should have height' do
    @item.variant.height_cm.should == 120
  end

  it 'should have price' do
    @item.price_pln.should == 20
  end
end
