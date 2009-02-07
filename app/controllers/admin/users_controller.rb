class Admin::UsersController < AdminController
  active_scaffold :users do |config|
    config.columns = [:email, :roles, :confirmed]
    config.list.columns = [:email, :roles, :confirmed]
    config.columns[:roles].form_ui = :select
    config.columns[:email].set_link :show
    config.columns[:roles].clear_link
  end
end
