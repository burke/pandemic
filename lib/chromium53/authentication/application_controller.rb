module Chromium53
  module Authentication
    module ApplicationController
        
      def self.included(controller)
        controller.send(:include, InstanceMethods)
        controller.send(:helper_method, :current_user, :current_user_session)
        controller.send(:filter_parameter_logging, :login, :password, :password_confirmation)
        controller.send(:helper,:all)
      end
    
      module InstanceMethods
        def call_rake(task, options = {})
          options[:rails_env] = Rails.env
          args = options.map { |key,value| "#{key.to_s.upcase}='#{value}'" }
          system "rake #{task} #{args.join(' ')} --trace >> #{Rails.root}/log/rake.log &"
        end

        private
         def current_user_session
           return @current_user_session if defined?(@current_user_session)
           @current_user_session = UserSession.find
         end
         
         def current_user
           return @current_user if defined?(@current_user)
           @current_user = current_user_session && current_user_session.record
         end
         
         def require_user
           unless current_user
             store_location
             flash[:notice] = "You must be logged in to access this page"
             redirect_to login_url
             return false
           end
         end
         def insufficient_privileges
           flash[:notice] = "You do not have sufficient privileges"
           redirect_to dashboard_url
         end

         def require_no_user
           if current_user
             store_location
             flash[:notice] = "You are already logged in"
             redirect_to dashboard_url
             return false
           end
         end

         def store_location
           session[:return_to] = request.request_uri
         end
         
         def redirect_back_or_default(default)
           redirect_to(session[:return_to] || default)
           session[:return_to] = nil
        end
      end 
    end
  end
end


