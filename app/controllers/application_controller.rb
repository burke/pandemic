class ApplicationController < ActionController::Base
  include HoptoadNotifier::Catcher
  include Chromium53::Authentication::ApplicationController
end
