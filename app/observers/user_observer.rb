class UserObserver < ActiveRecord::Observer
  unloadable
  def after_create(user)
    user.reset_perishable_token!
    UserMailer.deliver_confirmation(user)
  end
end


