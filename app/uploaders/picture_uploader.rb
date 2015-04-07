class PictureUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :index do
    process resize_to_fill: [640, 640]
  end

  version :show do
    process resize_to_limit: [640, 640]
  end



  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
