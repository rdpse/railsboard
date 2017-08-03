require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EBPainel
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    
    
    # ActionMailer
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.smtp_settings = {
      address: "smtp.example.com",
      port: 587,
      domain: 'example.com',
      user_name: 'username',
      password: ENV['RAILSBOARD_SMTP_PASSWORD'],
      authentication: :login,
      enable_starttls_auto: true
    }

    config.action_mailer.default_url_options = {
      host: "example.com"
    }

    config.action_mailer.asset_host = 'https://example.com'

  end
end
