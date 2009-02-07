class Admin::RolesController < AdminController
  layout "activescaffold"

  active_scaffold :roles do |config|
    config.columns = [:name, :description, :users_count]
    config.columns[:users_count].label = "Users"
    config.nested.add_link("Show Users", [:users])
    config.columns[:name].set_link :show
    [:create, :show, :update].each {|a| config.send(a).columns.remove [:users_count]}
  end

end
