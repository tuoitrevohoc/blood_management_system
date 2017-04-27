# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
assets_stylesheet = <<-CSS_FILES
  customize_alert.css customize_checkboxes.css material/material-dashboard.css
  admin/main.css libs/nanoscroller.css
CSS_FILES
assets_javascript = <<-JS_FILES
  material/material.min.js material/material-dashboard.js admin/main.js ckeditor/*
  admin/jquery.nanoscroller.min.js locationpicker/locationpicker.jquery.min.js
JS_FILES
Rails.application.config.assets.precompile += assets_stylesheet.split(" ") + assets_javascript.split(" ")
