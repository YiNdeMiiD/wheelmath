require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Wheelmath
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib/modules)
    config.active_record.raise_in_transactional_callbacks = true
    config.action_dispatch.default_headers.merge!({
      'Access-Control-Allow-Origin' => '*',
      'Access-Control-Request-Method' => '*'
    })
  end
end
