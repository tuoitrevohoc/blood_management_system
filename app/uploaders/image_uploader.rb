class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file
  # storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path("fallback/" +
      [version_name, "default_article.png"].compact.join('_'))
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
end
