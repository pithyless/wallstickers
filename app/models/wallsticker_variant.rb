class WallstickerVariant < ActiveRecord::Base
  belongs_to :wallsticker

  concerned_with :validation

  attr_accessible nil
end
