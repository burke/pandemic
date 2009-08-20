meetings = Meeting.all

@contact = []
def register_contact(duration=3600, people)
  people.each do |person|
    @contact[person] ||= []
    people.each do |sper|
      @contact[person][sper] ||= 0
      @contact[person][sper] += 1
    end
  end
end
  
meetings.each do |meeting|
  register_contact(meeting.duration, meeting.all_people)
end

o = "graph G {\n"
@contact.each_with_index do |x, i|
  if x
    x.each_with_index do |xy, j|
      if xy
        o << "h#{i} -- h#{j};\n"
      end
    end
  end
end

o << "}\n"
