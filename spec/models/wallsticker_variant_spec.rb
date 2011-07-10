require 'spec_helper'

describe WallstickerVariant, 'validates new' do
  it { should validate_presence_of :wallsticker }
  it { should validate_presence_of :color }
  it { should validate_presence_of :width_cm }
  it { should validate_presence_of :height_cm }
  it { should validate_presence_of :price_pln }

  it 'should fabricate' do
    sticker = Fabricate(:wallsticker_variant)
    sticker.should be_valid
    sticker.save.should be_true
  end
end

describe WallstickerVariant, 'color' do
  before(:each) do
    @variant = Fabricate(:wallsticker_variant)
  end

  it 'should accept hex color' do
    @variant.color = '4e24fa'
    @variant.should be_valid
  end

  it 'should not accept non-hex color' do
    @variant.color = 'badhex'
    @variant.should_not be_valid
    @variant.color = '12345'
    @variant.should_not be_valid
    @variant.color = '1234567'
    @variant.should_not be_valid
  end

  it 'should upcase chars' do
    @variant.color = 'abcdef'
    @variant.color.should == 'ABCDEF'
  end
end
