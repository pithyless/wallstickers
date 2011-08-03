class WallstickerVariant < ActiveRecord::Base
  belongs_to :wallsticker
  has_one :order

  concerned_with :validation

  attr_accessible nil
end
