class SalePhoto < ActiveRecord::Base
  mount_uploader :image, SalePhotoUploader

  belongs_to :wallsticker

  attr_accessible :image, :wallsticker

  validates_presence_of   :image
  validates_integrity_of  :image
  validates_processing_of :image
end
