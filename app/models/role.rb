class Role < ActiveRecord::Base
  has_many :user_roles
  has_many :users, :through => :user_roles
  
  def name=(name)
    write_attribute :name, name.to_s.downcase
  end
end
