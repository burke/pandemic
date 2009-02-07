class Admin::UsersController < AdminController
  active_scaffold :users do |config|
    config.columns = [:email, :roles, :confirmed, :password, :password_confirmation]
    config.update.columns << [:password, :password_confirmation]
    config.create.columns << [:password, :password_confirmation]
    config.columns[:password].form_ui = :password
    config.columns[:password_confirmation].form_ui = :password
    config.list.columns = [:email, :roles, :confirmed]
    config.columns[:roles].form_ui = :select
    config.columns[:email].set_link :show
    config.columns[:roles].clear_link
  end
end
