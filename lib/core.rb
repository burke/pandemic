module Chromium53
  module App
    module Controllers
      module ApplicationController
    
        def self.included(controller)
          controller.send(:include, InstanceMethods)
          
          controller.class_eval do
            helper_method :current_user,
                          :signed_in?
            
            hide_action :current_user, 
                        :signed_in?
          end
        end
        
        module InstanceMethods
          def current_user
            # future "Feature" cascade
            @current_user ||= (user_from_session || user_from_cookie)
          end

          def signed_in?
            !current_user.nil?
          end
          
          protected
          
          def authenticate(opts={})
            deny_access(opts) unless signed_in?
          end

          # "cascade"
          def user_from_session
            if session[:user_id]
              user = User.find_by_id(session[:user_id])
              user && user.confirmed? ? user : nil                
            end
          end

          def user_from_cookie
            if cookies[:remember_token]
              user = User.find_by_token(cookies[:remember_token])
              user && user.remember? ? user : nil                
            end
          end

          def login(user)
            if user
              session[:user_id] = user.id
              @current_user = user
            end
          end

          def redirect_back_or(default)
             session[:return_to] ? redirect_to(session[:return_to]) : redirect_to(default)
             session[:return_to] = nil
          end

          def redirect_to_root
            redirect_to root_url
          end

          def store_location
            session[:return_to] = request.request_uri if request.get?
          end

          def deny_access(opts = {})
            store_location
            flash[:error] = opts[:flash] if opts[:flash]
            render :template => "/sessions/new", 
                   :layout => "application",
                   :status => :unauthorized 
          end
        end
      end
    end
  end
end

