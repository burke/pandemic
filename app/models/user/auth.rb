class User < ActiveRecord::Base
  
  def self.authenticate(email, password)
    user = find_by_email email
    user && user.authenticated?(password) ? user : nil
  end
  
  def authenticated?(password)
    crypted_password == encrypt(password)
  end
  
  def encrypt(password)
    Digest::SHA1.hexdigest "--#{salt}--#{password}--"
  end
  
  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at
  end
  
  def remember_me!
    remember_me_until 2.weeks.from_now.utc
  end
  
  def remember_me_until(time)
    self.update_attribute :remember_token_expires_at, time
    self.update_attribute :remember_token, encrypt("#{email}--#{remember_token_expires_at}")
  end
  
  def forget_me!
    self.update_attribute :remember_token_expires_at, nil
    self.update_attribute :remember_token, nil
  end
  
  def confirm!
    self.update_attribute :confirmed, true
  end
  
  protected
  def initialize_salt
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--") if new_record?
  end
  
  def encrypt_password
    return if password.blank?
    self.crypted_password = encrypt(password)
  end
  
  def password_required?
    crypted_password.blank? || !password.blank?
  end
end
