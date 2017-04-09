require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BloodManagementSystem
  class Application < Rails::Application
    config.time_zone = "Hanoi"
    config.i18n.default_locale = :vi
    config.i18n.load_path += Dir["#{Rails.root.to_s}/config/locales/**/*.{rb,yml}"]
    config.action_view.field_error_proc = Proc.new {|html_tag, instance| html_tag.html_safe}
  end
end
