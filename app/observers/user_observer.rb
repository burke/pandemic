class UserObserver < ActiveRecord::Observer
  def after_create(user)
    user.reset_perishable_token!
    UserMailer.deliver_confirmation(user)
  end
  def after_unconfirm!(user)
    user.reset_perishable_token!
    UserMailer.devlier_confirmation(user)
  end
end


