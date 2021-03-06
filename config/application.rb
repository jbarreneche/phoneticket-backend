require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module PhoneTicket
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Buenos Aires'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es
    config.i18n.locale = :es

    config.autoload_paths << Rails.root + "lib" + "services"
    config.autoload_paths << Rails.root + "lib" + "payments"
    config.autoload_paths << Rails.root + "lib" + "mail_previews" if Rails.env.development?

    config.to_prepare do
      Devise::Mailer.layout "basic_email"
    end

    config.to_prepare do
      shapes = YAML.load_file(Rails.root + "config" + "shapes.yml")
      Shape::SHAPES_CACHE.clear
      Shape::CONFIGS.replace shapes
    end
  end
end
