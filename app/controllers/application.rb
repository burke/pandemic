# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include HoptoadNotifier::Catcher

  protect_from_forgery
  
  helper_method :current_user,
                :logged_in?
  def current_user
    @current_user ||= (user_from_session || user_from_cookie)
  end
  
  def logged_in?
    current_user
  end
  
  def authenticate(opts = {})
    deny_access(opts) unless self.current_user
  end
  
  def user_from_session
    User.find_by_id session[:user_id]
  end
  
  def user_from_cookie
    user = User.find_by_remember_token(cookies[:auth_token][:remember_token]) if cookies[:auth_token] && cookies[:auth_token][:remember_token]
    user && user.remember_token? ? user : nil
  end
  
  def login(user)
    create_session_for(user)
    @current_user = user
  end
  
  def create_session_for(user)
    session[:user_id] = user.id if user
  end
 
  def redirect_to_root
    redirect_to root_url
  end  
  def redirect_back_or(default)
    session[:return_to] ? redirect_to(session[:return_to]) : redirect_to(default)
    session[:return_to] = nil
  end
  
  def store_location
    session[:return_to] = request.request_uri
  end
 
  def deny_access(opts = {})
    opts[:redirect] ||= login_url
    #opts[:flash_message] ||= ''#"You must be logged in to view this page, Please login or signup for a new account to continue"
    store_location
   # flash[:error] = opts[:flash_message] 
    redirect_to opts[:redirect]
  end
end
