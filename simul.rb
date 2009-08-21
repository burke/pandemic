NUM_PEOPLE = 1800
UNIT_SIZE = 10



class Person

  attr_reader :contact, :pid
  
  def initialize(pid)
    @pid = pid
    x = @pid/UNIT_SIZE*UNIT_SIZE
    @workgroup = (x...x+UNIT_SIZE).to_a
    @contact = []
  end

  def self.find(pid)
    $people[pid]
  end
  
  def simulate
    loop do
      case rand*100
      when 0..13
        return
      when 14..81
        docontact(random_from_workgroup, random_duration)
      when 82..100
        docontact(random_from_world, random_duration)
      end
    end
  end

  def random_duration
    rand(3600*8)
  end
  
  def docontact(person, duration)
    return if @contact.map{|e|e[0]}.include?(person)
    @contact << [person, duration]
  end
  
  def random_from_workgroup
    Person.find(@workgroup[rand*@workgroup.size])
  end

  def random_from_world
    Person.find((NUM_PEOPLE*rand).to_i)
  end
  
end


class Simulation
  def initialize
    $people = []
    NUM_PEOPLE.times do |i|
      $people[i] = Person.new(i)
    end
  end

  def run
    $people.each do |person|
      #puts "simulating person #{person.pid}"
      person.simulate
    end
    self
  end

  def color(duration)
    ratio = duration / (3600*8.to_f)
    dec = ratio * 255
    hex = dec.to_i.to_s(16)
    s="#{hex}#{hex}#{hex}"
    if s.size==3
      s *= 2
    end
    return "##{s}"
  end
  
  def printdot
    puts "graph G {"
    $people.each do |person|
      x = {}
      person.contact.each{|c|x[c[0].pid] = c[1]}
      x.each do |p, d|
        puts "  {edge [color=\"#{color(d)}\"] h#{person.pid} -- h#{p} }"
      end
    end
    puts "}"
    self
  end
  
end


if __FILE__ == $0
  Simulation.new.run.printdot
end
