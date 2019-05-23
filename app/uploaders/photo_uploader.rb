class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Cloudinary::CarrierWave
  include ActionView::Helpers::AssetUrlHelper

  def default_url
    "#{Settings.cloudinary_default_path}#{cloudinary_version}/#{Settings.avatar_cloudinary.file}"
  end

  process resize_to_fit: [500, 500]

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def public_id
    "#{model.class.to_s.underscore}_#{model.id}_#{SecureRandom.uuid}"
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
