SubscriptionService::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { :host => 'localhost:5000' }

  ActionMailer::Base.smtp_settings = {
      :port =>           '587',
      :address =>        'smtp.mandrillapp.com',
      :user_name =>      ENV['MANDRILL_USERNAME'],
      :password =>       ENV['MANDRILL_APIKEY'],
      :domain =>         'heroku.com',
      :authentication => :plain
  }
  ActionMailer::Base.delivery_method = :smtp

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  
  # Paperclip configuration
  Paperclip.options[:command_path] = "/usr/local/bin/"
  
  # Braintree configuration
  Braintree::Configuration.environment = :sandbox
  Braintree::Configuration.merchant_id = "jqwp7bxpf82fvr29"
  Braintree::Configuration.public_key = "mwy7rhr4d6mg69fk"
  Braintree::Configuration.private_key = "0276ad6a51d5aa4b2335ca49d5d2badf"
end