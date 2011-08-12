# encoding: utf-8

class SalePhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads/#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}"
  end

  def extension_white_list
    %w(jpg jpeg)
  end

  process :resize_to_fill => [430, 645]
end
