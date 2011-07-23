class Wallsticker < ActiveRecord::Base
  mount_uploader :source_image, SourceStickerUploader

  concerned_with :validation

  belongs_to :artist

  attr_accessible :title, :source_image

  def to_param
    username, title = self.permalink.split('-', 2)
    "#{username}/#{title}"
  end
end
