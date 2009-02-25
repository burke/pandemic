class ApplicationController < ActionController::Base
  include HoptoadNotifier::Catcher

  protect_from_forgery
  
  helper_method :current_user,
                :logged_in?

  hide_action :current_user, :signed_in?

 
  def current_user
    @current_user ||= (user_from_session || user_from_cookie)
  end
  
  def logged_in?
    current_user
  end
  
  protected

  def authenticate(opts = {})
    debugger
    deny_access(opts) unless current_user
  end
  
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
    session[:return_to] = request.request_uri if request.get?
  end
 
  def deny_access(opts = {})
    store_location
    flash[:error] = opts[:flash] if opts[:flash]
    render :template => "/sessions/new", 
           :layout => "application", 
           :status => :unauthorized 
  end

  def call_rake(task, options = {})
    options[:rails_env] = Rails.env
    args = options.map { |key,value| "#{key.to_s.upcase}='#{value}" }
    system "rake #{task} #{args.join(' ')} --trace >> #{Rails.root}/log/rake.log &"
  end
end
