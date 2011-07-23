class Wallsticker < ActiveRecord::Base
  mount_uploader :source_image, SourceStickerUploader

  concerned_with :validation

  belongs_to :artist

  attr_accessible :title, :source_image

  def to_param
    permalink
  end

  def url_path
    first, title = self.permalink.split('-', 2)
    "/#{first}/#{title}"
  end

end
