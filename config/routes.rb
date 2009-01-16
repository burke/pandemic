ActionController::Routing::Routes.draw do |map|
  map.resources :accounts

  
  map.root     :controller => "static", :action => "index"
  
  map.login    '/login',    :controller => 'sessions', :action => 'new'
  map.logout   '/logout',   :controller => 'sessions', :action => 'destroy'
  map.register '/register', :controller => 'users',    :action => 'new'
  
  map.resources :users
  map.resource  :session

  map.home '/home', :controller => 'home'
  map.namespace(:home) do |home|
    home.resource :password do |password|
      password.connect '/reset', :controller => 'passwords',:action => 'reset'
    end
  end
  
  map.admin '/admin', :controller => 'admin'
  map.namespace(:admin) do |admin|
    admin.resources :users
    admin.resources :roles
  end
  
  map.confirmation '/confirm/:user_id/:salt', :controller => 'users', :action => 'confirm'
  map.connect  ':action',   :controller => 'static'

end
