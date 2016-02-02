require File.expand_path('../boot', __FILE__)
require 'rails/all'
Bundler.require(*Rails.groups)

module Bookstore
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.default_options = { from: 'rails_bookstore@example.com' }
    config.action_mailer.smtp_settings = {
      address:              'smtp.mailgun.org',
      port:                 587,
      domain:               'example.com',
      user_name:            ENV["MAILGUN_USERNAME"],
      password:             ENV["MAILGUN_PASSWORD"],
      authentication:       'plain',
      enable_starttls_auto: true }
  end
end
