class User < ActiveRecord::Base
  acts_as_authentic do |config|
    config.perishable_token_valid_for = 1.hour
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
