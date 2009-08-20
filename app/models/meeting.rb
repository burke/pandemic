class Meeting < ActiveRecord::Base

  belongs_to :user

  has_many :meeting_people
  has_many :people, :through => :meeting_people

  validates_presence_of :duration, :people
  
  def time_str
    if (duration % 3600).zero?
      return "#{duration/3600} hours"
    else
      return "#{duration/60} minutes"
    end
  end
  
end
