RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  config.gem 'mocha', :version => '0.9.4'
  config.gem 'thoughtbot-shoulda',       :lib => 'shoulda',      :source => "http://gems.github.com"
  config.gem 'thoughtbot-factory_girl',  :lib => 'factory_girl', :source => "http://gems.github.com"
  config.gem 'stefanpenner-my_scaffold', :lib => false,          :source => "http://gems.github.com"
  config.gem 'iridesco-time-warp',       :lib => 'time_warp',    :source => "http://gems.github.com"
  config.gem 'authlogic'
  config.load_paths += %W( #{RAILS_ROOT}/app/sweepers/
                           #{RAILS_ROOT}/app/observers/
                           #{RAILS_ROOT}/app/mailers/)
  
  config.time_zone = 'UTC'

  config.action_controller.session = {
    :session_key => '_base_session',
    :secret      => 'db41de5aa5f94f31138ef67e73ce7163a08323d5499ce01b9455253e9670a5113e9cd7cc774f503668d0e1446efe6499884eb2d4e74283fbf726df264792168e'
  }

  config.active_record.observers = :user_observer
end
