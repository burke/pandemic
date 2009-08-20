class GraphController < ApplicationController

  
  def dot
    meetings = Meeting.all
    
    @contact = []
    
    meetings.each do |meeting|
      register_contact(meeting.duration, meeting.all_people)
    end
    
    o = "<pre>graph G {\n"
    @contact.each_with_index do |x, i|
      if x
        x.each_with_index do |xy, j|
          if xy
            colorstring = colorstring(xy)
            o << "  { edge [color=\"#{colorstring}\"]\n"
            o << "    h#{i} -- h#{j} }\n"
          end
        end
      end
    end
    
    o << "}\n</pre>"

    render :text => o
  end

  private
  def register_contact(duration, people)
    return if people.nil?
    people.each do |person|
      @contact[person.id] ||= []
      people.each do |sper|
        @contact[person.id][sper.id] ||= 0
        @contact[person.id][sper.id] += duration||1
      end
    end
  end

  def weight(duration)
    @max_duration ||= @contact.map{|c|c.max rescue 0}.max.to_f
    return duration / @max_duration
  end

  def colorstring(duration)
    weight = weight(duration)
    # weight is (0,1]
    # we'll draw [1,4] parallel lines.
    return "#000000:#CC0000"
  end
  
end
