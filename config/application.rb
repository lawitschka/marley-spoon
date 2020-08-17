require_relative 'boot'

# require 'rails/all'
# This is not loaded in rails/all but inside active_record so add it if
# you want your models work as expected
# require "active_model/railtie"
# And now the rest
require "action_controller/railtie"
# require "action_mailer/railtie"
require "action_view/railtie"
# require "active_job/railtie" # Only for Rails >= 4.2
# require "action_cable/engine" # Only for Rails >= 5.0
require "sprockets/railtie"
require "rails/test_unit/railtie"

# All these depend on active_record, so they should be excluded also
# require "active_storage/engine" # Only for Rails >= 5.2

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MarleySpoon
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
