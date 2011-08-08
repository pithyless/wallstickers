class WallstickerVariant < ActiveRecord::Base
  validates :wallsticker, :presence => true
  validates :width_cm,    :presence => true
  validates :height_cm,   :presence => true
  validates :price_pln,   :presence => true

  validates_numericality_of :width_cm, :only_integer => true, :greater_than => 0
  validates_numericality_of :height_cm, :only_integer => true, :greater_than => 0
  validates_numericality_of :price_pln, :greater_than => 0
end
