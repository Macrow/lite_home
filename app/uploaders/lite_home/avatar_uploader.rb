# encoding: utf-8
module LiteHome
  class AvatarUploader < ::CarrierWave::Uploader::Base

    # Include RMagick or MiniMagick support:
    # include CarrierWave::RMagick
    include CarrierWave::MiniMagick

    # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
    # include Sprockets::Helpers::RailsHelper
    # include Sprockets::Helpers::IsolatedHelper

    # Choose what kind of storage to use for this uploader:
    storage :file
    # storage :fog
    
    process :resize_to_limit => [500, 500]
    
    # Crop source is a source image converted from original which could be bigger than source area (left image in the example).
    version :max do
      process :resize_to_limit => [LiteHome.users_avatar_max_size, LiteHome.users_avatar_max_size]
    end
    
    version :middle do
      process :resize_to_limit => [LiteHome.users_avatar_middle_size, LiteHome.users_avatar_middle_size]
    end    
    
    # This is the cropped version of parent image. Let crop to 50x50 square.
    version :min do
      process :resize_to_limit => [LiteHome.users_avatar_min_size, LiteHome.users_avatar_min_size]
    end

    # Override the directory where uploaded files will be stored.
    # This is a sensible default for uploaders that are meant to be mounted:
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.name}"
    end
    
    before :store, :remember_cache_id
    after :store, :delete_tmp_dir
    
    # store! nil's the cache_id after it finishes so we need to remember it for deletition
    def remember_cache_id(new_file)
      @cache_id_was = cache_id
    end
    
    def delete_tmp_dir(new_file)
      # make sure we don't delete other things accidentally by checking the name pattern
      if @cache_id_was.present? && @cache_id_was =~ /\A[\d]{8}\-[\d]{4}\-[\d]+\-[\d]{4}\z/
        FileUtils.rm_rf(File.join(cache_dir, @cache_id_was))
      end
    end    

    # Provide a default URL as a default if there hasn't been a file uploaded:
    # def default_url
    #   # For Rails 3.1+ asset pipeline compatibility:
    #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
    #
    #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
    # end

    # Process files as they are uploaded:
    # process :scale => [200, 300]
    #
    # def scale(width, height)
    #   # do something
    # end

    # Create different versions of your uploaded files:
    # version :thumb do
    #   process :scale => [50, 50]
    # end

    # Add a white list of extensions which are allowed to be uploaded.
    # For images you might use something like this:
    def extension_white_list
      %w(jpg jpeg gif png)
    end

    # Override the filename of the uploaded files:
    # Avoid using model.id or version_name here, see uploader/store.rb for details.
    # def filename
    #   "something.jpg" if original_filename
    # end

  end
end
