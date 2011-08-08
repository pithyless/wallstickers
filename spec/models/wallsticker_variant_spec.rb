require 'spec_helper'

describe WallstickerVariant, 'validates new' do
  it { should validate_presence_of :wallsticker }
  it { should validate_presence_of :width_cm }
  it { should validate_presence_of :height_cm }
  it { should validate_presence_of :price_pln }

  it { should validate_numericality_of :width_cm }
  it { should validate_numericality_of :height_cm }
  it { should validate_numericality_of :price_pln }

  it 'should fabricate' do
    sticker = Fabricate(:wallsticker_variant)
    sticker.should be_valid
    sticker.save.should be_true
  end
end
