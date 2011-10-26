class Wallsticker < ActiveRecord::Base
  MAX_SALE_PHOTOS = 3

  mount_uploader :source_image, SourceStickerUploader
  mount_uploader :browse_image, BrowsePhotoUploader

  # TODO: browse_image may be null! Need to fix this...

  concerned_with :validation

  belongs_to :artist
  belongs_to :category
  has_many   :sale_photos

  # TODO! this is not being tested due to VERY slow tests...
  validates_presence_of :sale_photos unless Rails.env.test?

  accepts_nested_attributes_for :sale_photos, :limit => MAX_SALE_PHOTOS

  attr_accessible :title, :description, :category_id, :source_image, :browse_image, :sale_photos_attributes

  def image_urls
    imgs = sale_photos.order('created_at asc').map {|x| x.image_url}
    imgs << source_image_url
  end

  def image_url
    image_urls[0]
  end

  def square_image_url
    browse_image_url
  end

  def small_square_image_url
    browse_image.small.url
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
