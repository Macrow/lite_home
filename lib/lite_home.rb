require "lite_home/engine"
require "lite_home/version"
require 'bootstrap-sass'
require 'compass-rails'
require "sorcery"
require "carrierwave"
require 'mini_magick'
require 'ransack'
require 'simple_form'
require 'will_paginate'

module LiteHome
  class << self
    def config
      yield self
    end
    
    def has_config(key, options)
      mattr_accessor key
      class_variable_set("@@#{key}", options[:default])
    end    
    
    def root
      @root ||= Pathname.new(File.expand_path('../../', __FILE__))
    end    
  end
  
  has_config :site_name, default: 'Lite'
  has_config :site_domain, default: 'localhost'
  has_config :admin_email, default: 'notifications@example.com'
  has_config :layout_name, default: 'lite_layout'
  has_config :display_flash_message, default: false
  has_config :users_per_page, default: 10
  has_config :users_avatar_max_size, default: 300
  has_config :users_avatar_middle_size, default: 100
  has_config :users_avatar_min_size, default: 50
end
