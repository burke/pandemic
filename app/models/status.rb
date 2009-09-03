class Status < ActiveRecord::Base

  belongs_to :user

  def self.user_today(user)
    # ghetto-style cast to bool
    return !! self.find(:first, :conditions => ["user_id = ? and created_at > ?", user.id, Date.today])
  end
  
end
