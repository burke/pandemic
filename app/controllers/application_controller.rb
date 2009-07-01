class ApplicationController < ActionController::Base
  include HoptoadNotifier::Catcher
  include Chromium53::Authentication::ApplicationController
  filter_parameter_logging :login, :password, :password_confirmation
end
