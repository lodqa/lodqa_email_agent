require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # SMTPサーバーの設定
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.default_url_options = { host: ENV['HOST_LODQA_EMAIL_AGENT'] }

    # POPサーバーの設定
    config.pop_settings = {
      address: ENV['POP_ADDRESS'],
      port: ENV['POP_PORT'],
      user_name: ENV['POP_USERNAME'],
      password: ENV['POP_PASSWORD'],
      # 暗号化あり:true、暗号化なし:falseを指定する必要がある。
      use_ssl: ENV['POP_USESSL'] == 'true'
    }
  end
end
