class UserMailer < ActionMailer::Base
  default_url_options[:host] = APP[:host]
  def forgotten_password(user)
    from       'DO_NOT_REPLY@gmail.com'
    recipients user.email
    subject    "[#{APP[:name].humanize}] Change your password"
    body       :user => user
  end
  
  def confirmation(user)
    recipients user.email
    from       'DO_NOT_REPLY@gmail.com'
    subject   "[#{APP[:name].humanize}] Account confirmation"
    body      :user => user
  end
end
