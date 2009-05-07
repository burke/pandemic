class UserObserver < ActiveRecord::Observer
  def after_create(user)
    UserMailer.deliver_confirmation(user)
  end
end


