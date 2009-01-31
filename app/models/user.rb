class User < ActiveRecord::Base
  concerned_with :auth
  attr_accessible :email, :password, :password_confirmation, :role_ids
  
  named_scope :confirmed, :conditions => { :confirmed => true }
  
  attr_accessor   :password, :password_confirmation
  
  validates_presence_of     :email
  validates_presence_of     :password, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  validates_uniqueness_of   :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  before_save :initialize_salt, :encrypt_password
  
  has_many :user_roles
  
  has_many :roles, :through => :user_roles
  
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

end
