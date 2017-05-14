class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Cloudinary::CarrierWave
  include ActionView::Helpers::AssetUrlHelper

  def default_url
    "#{Settings.cloudinary_default_path}#{cloudinary_version}/#{Settings.avatar_cloudinary.file}"
  end

  version :thumb do
    process resize_to_fit: [64, 64]
  end

  version :medium do
    process resize_to_fit: [200, 200]
  end

  version :small do
    process resize_to_fit: [32, 32]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def public_id
    "#{model.class.to_s.underscore}_#{model.id}_#{model.class.secure_random_uuid}"
  end

  private
  def cloudinary_version
    size = case version_name
    when :medium
      200
    when :small
      32
    when :thumb
      64
    else
      return Settings.avatar_cloudinary.version
    end
    "c_fit,h_#{size},w_#{size}"
  end
end
