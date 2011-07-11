require 'spec_helper'

describe CartItem do
  it { should validate_presence_of :cart }
  it { should validate_presence_of :wallsticker_variant }

  it 'should fabricate' do
    sticker = Fabricate(:wallsticker_variant)
    sticker.should be_valid
    sticker.save.should be_true
  end
end

describe CartItem, 'attributes' do
  before :each do
    @cart = Fabricate(:user).cart
    @item = Fabricate(:cart_item, :cart => @cart)
  end

  it 'should have wallsticker variant' do
    @item.variant.should_not be_nil
    @item.variant.instance_of?(WallstickerVariant).should be_true
    @item.variant.width_cm.should == 40
  end

  it 'should have price' do
    @item.price_pln.should == 31
  end
end
