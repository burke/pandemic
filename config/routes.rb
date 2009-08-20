ActionController::Routing::Routes.draw do |map|
  map.resources :statuses

  map.resources :meeting_people

  map.resources :people

  map.resources :meetings

  map.root :controller => 'front'
  
  map.suggest '/suggest.:format', :controller => 'people', :action => 'suggest'
  
  map.resources :meeting_users
  map.resources :meetings

  Chromium53::Routes.add_to(map)
end
