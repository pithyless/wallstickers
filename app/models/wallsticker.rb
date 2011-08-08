class Wallsticker < ActiveRecord::Base
  mount_uploader :source_image, SourceStickerUploader

  concerned_with :validation

  belongs_to :artist
  has_many   :sale_photos
  accepts_nested_attributes_for :sale_photos

  attr_accessible :title, :description, :source_image, :sale_photos_attributes

  def image_urls
    sale_photos.map {|x| x.image_url} + [source_image_url]
  end

  def image_url
    image_urls[0]
  end

  def to_param
    username, title = self.permalink.split('-', 2)
    "#{username}/#{title}"
  end

  def self.from_param(str)
    Wallsticker.find_by_permalink(str.sub('/', '-'))
  end

  def self.from_param!(str)
    Wallsticker.find_by_permalink!(str.sub('/', '-'))
  end

  def self.top_featured(limit=5)
    self.order('created_at desc').limit(limit) # TODO
  end
end
