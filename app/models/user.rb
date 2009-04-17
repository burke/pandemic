class User < ActiveRecord::Base
  attr_accessible :email, 
                  :password, 
                  :password_confirmation, 
                  :role_ids

  named_scope :confirmed, :conditions => { :confirmed => true }

  attr_accessor   :password, :password_confirmation

  validates_presence_of     :email
  validates_presence_of     :password, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  validates_uniqueness_of   :email
  validates_format_of       :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

 # before_create :send_welcome_email

  before_save :initialize_salt, :encrypt_password

  has_many :user_roles

  has_many :roles, :through => :user_roles

  def send_welcome_email
    UserMailer.deliver_confirmation self
  end
  # for active_scaffold
  def to_label
    email
  end
  
  # role stuff
  def role_ids=(role_ids)
    update_attribute :roles, Role.find(role_ids) || []
  end


  def is_one_of?(*args)
    args.any?{ |num| roles.include?(num)}
  end

  def is_an?(*roles_in_question)
    !roles.find_by_name(roles_in_question.map(&:to_s)).blank?
  end
  # auth stuff

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
    remember_token_expires_at && Time.now < remember_token_expires_at
  end

  def remember_me!
    remember_me_until 2.weeks.from_now.utc
  end
  
  def remember_me_until(time)
    self.update_attribute :remember_token_expires_at, time
    self.update_attribute :remember_token, encrypt("#{email}--#{remember_token_expires_at}")
    save(false)      
  end

  def forget_me! 
    self.update_attribute :remember_token_expires_at, nil
    self.update_attribute :remember_token, nil
  end

  def confirmed?
    confirmed
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
