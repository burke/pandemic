ActionController::Routing::Routes.draw do |map|

  %W{ index }.each do |page|
    map.connect page, :controller => 'static', :action => page
  end
  
  map.root     :controller => "static", :action => "index"
  map.resource :user_session
 
  map.login    '/login',    :controller => 'user_sessions', :action => 'new'
  map.logout   '/logout',   :controller => 'user_sessions', :action => 'destroy'
  map.register '/register', :controller => 'user', :action => 'new'
  map.resource  :session

  map.resource :password do |password|
    password.connect '/reset/:perishable_token', :controller => 'passwords',:action => 'reset'
  end

  map.confirmation '/confirm/:perishable_token', :controller => 'users', :action => 'confirm'

  map.resources :users

  map.dashboard '/dashboard', :controller => 'dashboard'
  map.namespace(:dashboard) do |dashboard|

    dashboard.resource :personal, :only => [:show, :edit, :update]
  end
  
  map.admin '/admin', :controller => 'admin'

  map.namespace(:admin) do |admin|
    admin.resources :users, :active_scaffold => true
    admin.resources :roles, :active_scaffold => true
    admin.resources :user_roles, :active_scaffold => true
  end
  
end
