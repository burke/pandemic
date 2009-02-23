ActionController::Routing::Routes.draw do |map|

  %W{ index }.each do |page|
    map.connect page, :controller => 'static', :action => page
  end
  
  map.root     :controller => "static", :action => "index"
  
  map.login    '/login',    :controller => 'sessions', :action => 'new'
  map.logout   '/logout',   :controller => 'sessions', :action => 'destroy'
  map.register '/register', :controller => 'users',    :action => 'new'
  
  map.resources :users
  map.resource  :session

  map.dashboard '/dashboard', :controller => 'dashboard'
  map.namespace(:dashboard) do |dashboard|

    dashboard.resource :personal, :only => [:show, :edit, :update]
  end

  map.resource :password do |password|
    password.connect '/reset', :controller => 'passwords',:action => 'reset'
  end
  
  map.admin '/admin', :controller => 'admin'

  map.namespace(:admin) do |admin|
    admin.resources :users, :active_scaffold => true
    admin.resources :roles, :active_scaffold => true
    admin.resources :user_roles, :active_scaffold => true
  end
  
  map.confirmation '/confirm/:salt', :controller => 'users', :action => 'confirm'
end
