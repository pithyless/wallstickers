class Wallsticker < ActiveRecord::Base
  mount_uploader :source_image, SourceStickerUploader

  concerned_with :validation

  belongs_to :artist

  attr_accessible :title, :source_image

  def to_param
    username, title = self.permalink.split('-', 2)
    "#{username}/#{title}"
  end

  def self.from_param(str)
    permalink = str.sub('/', '-')
    Wallsticker.find_by_permalink(permalink)
  end

  def self.top_featured(limit=5)
    self.order('created_at desc').limit(limit) # TODO
  end

  def image_urls
    # TODO: return PR images before source_image
    [source_image_url]
  end

  def image_url
    image_urls[0]
  end
end
