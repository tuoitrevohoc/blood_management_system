# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
assets_stylesheet = %W(material/material-dashboard.css)
assets_javascript = %W(material/material.min.js material/material-dashboard.js)
Rails.application.config.assets.precompile += assets_stylesheet + assets_javascript
