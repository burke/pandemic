class User < ActiveRecord::Base
  concerned_with :auth
  attr_accessible :email, :password, :password_confirmation, :role_ids
  
  named_scope :confirmed, :conditions => { :confirmed => true }
  
  attr_accessor   :password, :password_confirmation
  
  validates_presence_of     :email
  validates_presence_of     :password, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  validates_uniqueness_of   :email
  
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
  
  def method_missing(method_id, *args)
    #debugger
    if match = method_id.to_s.match(/^is_an?_(\w+)\?$/)
      roles_in_question = match.captures.split('_or_')
      !roles.find_by_name(*roles_in_question).blank?
    else
      super
    end
  end

end