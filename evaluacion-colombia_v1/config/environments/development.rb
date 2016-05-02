Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  config.web_console.whitelisted_ips = "0.0.0.0/0"

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = false

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Configuracion de email
  

  config.action_dispatch.best_standards_support = :builtin

  config.active_support.deprecation = :notify
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.default :charset => "utf-8"
  #Encoding.default_external = Encoding::UTF_8
  #Encoding.default_internal = Encoding::UTF_8


  #config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.active_support.deprecation = :log
  
  config.action_mailer.smtp_settings ={
    :enable_starttls_auto => true,
    :address            => 'smtp.gmail.com',
    :port               => 000,
    :domain             => 'gmail.com',
    :authentication     => :plain,
    #:user_name          => '',
    :user_name          => '',
    :password           => '',
    :ssl                  => true,
    :openssl_verify_mode  => 'none',
    #:tls =>    true

  }
  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Paperclip s3 config
  config.paperclip_defaults = {
    :storage => :s3,
    :s3_protocol => 'http',
    :url => ":s3_alias_url",
    :path => ":class/:attachment/:id_partition/:style/:filename",
    #:s3_host_alias => "d2iwi9ayydeo5b.cloudfront.net",
    :bucket => ENV["S3_BUCKET_NAME"],
    :s3_credentials => {
      :acces_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_acces_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
  }

  config.permit_videos = true
  config.serve_static_files = true
end
