class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Cloudinary::CarrierWave

  def default_url
    "#{Settings.cloudinary_default_path}#{cloudinary_version}/#{Settings.image_cloudinary.file}"
  end

  version :large do
    process resize_to_fit: [800, 600]
  end

  version :medium do
    process resize_to_fit: [320, 240]
  end

  version :small do
    process resize_to_fit: [80, 60]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def filename
    "#{model.class.to_s.underscore}_#{model.title_slug}.jpg" if original_filename.present?
  end

  def public_id
    model.title_slug
  end

  private
  def cloudinary_version
    h, w = nil
    case version_name
    when :large
      w = 800
      h = 600
    when :medium
      w = 320
      h = 240
    when :small
      w = 80
      h = 60
    else
      return Settings.avatar_cloudinary.version
    end
    "c_fit,h_#{h},w_#{w}"
  end
end
