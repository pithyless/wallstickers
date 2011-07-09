class WallstickerVariant < ActiveRecord::Base
  belongs_to :wallsticker

  concerned_with :validation
end
