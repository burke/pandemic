class User < ActiveRecord::Base
  attr_protected :state, :person

  belongs_to :person
  has_many :meetings
  has_many :statuses
  
  acts_as_authentic do |config|
    config.perishable_token_valid_for = 1.hour
  end

  def before_create
    p = Person.find_by_email(self.email)

    if p.nil? # This email isn't on the org list.
      self.errors.add :email, "Please use your organization email address."
      return false
    end
    
    if p.user # This email has already been claimed.
      self.errors.add :email, "has already been taken"
      return false
    end

    self.person = p

    return true
  end
  
  # simple state machine to handle user confirmation
  state_machine :initial => :unconfirmed do
    event :confirm! do
      transition :unconfirmed => :confirmed
    end

    state :confirmed
    event :unconfirm! do
      transition :confirmed => :unconfirmed
    end
  end
  
  def self.find_by_smart_case_login_field(user_login) 
    if user_login =~ Authlogic::Regex.email
      first(:conditions => ["LOWER(#{quoted_table_name}.email) = ?", user_login.downcase]) 
    else
      super
    end 
  end 
end
