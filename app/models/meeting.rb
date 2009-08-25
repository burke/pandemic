class Meeting < ActiveRecord::Base

  belongs_to :user

  has_many :meeting_people
  has_many :people, :through => :meeting_people

  validates_presence_of :duration, :people

  def all_people
    return [self.user.person, *self.people]
  end
  
  def time_str
    if (duration % 3600).zero?
      dur = duration/3600
      return "#{dur} hour#{dur==1 ? '' : 's'}"
    else
      return "#{duration/60} minutes"
    end
  end
  
end
