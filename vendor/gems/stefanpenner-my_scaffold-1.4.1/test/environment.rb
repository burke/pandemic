# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.2.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
 
  config.gem 'mocha'

  config.gem 'thoughtbot-shoulda', :lib => 'shoulda',
                                   :source => "http://gems.github.com"

  config.gem 'thoughtbot-factory_girl', :lib => 'factory_girl',
                                        :source => "http://gems.github.com"

  config.gem 'my_scaffold'

  config.action_controller.session = {
    :session_key => '_rails_test_session',
    :secret      => 'a8e3520f0ba3cd7472d3c92ea082962ad2b775f13d03fc82122a68a7d58bf2eef8a5413b077b15b3e8bce847a36327c11f5b26197ed1f06a833c67e5bb778cf2'
  }
end
