# encoding: utf-8
class CoverUploader < CarrierWave::Uploader::Base

  if ENV['LOCAL_STORAGE']
    include CarrierWave::MiniMagick
  else
    include Cloudinary::CarrierWave
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    ActionController::Base.helpers.image_url("no-cover.jpg")
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :admin do
    process resize_to_fill: [120, 160]
  end

  # Create different versions of your uploaded files:
  version :android do
    process resize_to_fill: [240, 320]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
