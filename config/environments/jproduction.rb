# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Enable threaded mode
 config.threadsafe!

# This is ugly.
# See: http://rails.lighthouseapp.com/projects/8994/tickets/802-eager-load-application-classes-can-block-migration
# Rails 2.2 loads too many things when running rake db:migrate, including activescaffold,
# which causes the migration to fail. 
if (File.basename($0) == "rake" && ARGV.include?("db:migrate"))
  config.eager_load_paths.clear
end

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true

# Use a different cache store in production
# config.cache_store = :mem_cache_store

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host                  = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

#jruby haxors
require 'digest/sha1'
