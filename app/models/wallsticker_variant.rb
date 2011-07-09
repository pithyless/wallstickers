class WallstickerVariant < ActiveRecord::Base
  belongs_to :wallsticker
  belongs_to :buyer, :class_name => 'User', :foreign_key => 'buyer_id'

  concerned_with :validation

  attr_accessible nil
end
