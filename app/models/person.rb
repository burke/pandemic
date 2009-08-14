class Person < ActiveRecord::Base

  has_many :meeting_people
  has_many :meetings, :through => :meeting_people

end
