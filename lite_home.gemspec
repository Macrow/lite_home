$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "lite_home/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lite_home"
  s.version     = LiteHome::VERSION
  s.authors     = ["Macrow"]
  s.email       = ["Macrow_wh@163.com"]
  s.homepage    = "http://github.com/Macrow/lite_home"
  s.summary     = "LiteHOME is a simple user center"
  s.description = "LiteHOME is a simple user center, It's a mountable engine."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency "rails"
  s.add_dependency "jquery-rails"
  s.add_dependency "sass-rails"
  s.add_dependency "haml-rails"
  s.add_dependency "bootstrap-sass"
  s.add_dependency "compass-rails"
  s.add_dependency "sorcery"
  s.add_dependency "carrierwave"
  s.add_dependency "mini_magick"
  s.add_dependency "ransack"
  s.add_dependency "simple_form"
  s.add_dependency "will_paginate"

  s.add_development_dependency "sqlite3"
end
