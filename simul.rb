require 'rubygems'
require 'activesupport'

NUM_PEOPLE = 250
UNIT_SIZE = 8

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
      when 0..25
        return
      when 14..85
        docontact(random_from_workgroup, random_duration)
      when 86..100
        docontact(random_from_world, random_duration)
      end
    end
  end

  def random_duration
    rand(3600*8)
  end
  
  def docontact(person, duration)
    return if person.pid == self.pid rescue nil
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

module Graph
  
  class Node
    attr_accessor :w
    attr_reader :edges, :name
    cattr_reader :rall
    @@rall = []
    def initialize(name)
      @@rall << self
      @name = name
    end

    def to_s
      "{node [color=\"#{color}\"] h#{name}}"
    end

    def self.color_all
      @@rall.each do |node|
        x = Edge.rall.select{|e|e.src == node.name || e.dest == node.name}
        fn = (x.size)**2
        fd = ((x.map(&:dur).inject(&:+)||0) / 3600.0)
        node.w = fn*fd
        @@w_max ||= node.w
        @@w_max = node.w if node.w > @@w_max
      end
    end
    
    def color
      unless defined?(@@w_max)
        Node.color_all
      end
      ratio = 1- (w / @@w_max.to_f)
      dec = 255-(ratio * 255)
      hex = dec.to_i.to_s(16)
      s=hex
      if s.size==1
        s *= 2
      end
      return "##{s}0000"
    end
  end

  class Edge
    attr_reader :src, :dest, :dur
    cattr_reader :rall
    @@rall = []
    def initialize(src,dest,dur)
      @@rall << self
      @src = src
      @dest = dest
      @dur = dur
    end
    def to_s
      "{edge [color=\"#{color}\"] h#{@src} -- h#{@dest} }"
    end

    def weight
      ratio = @dur / (3600*8.to_f)
    end
    
    def color
      ratio = @dur / (3600*8.to_f)
      dec = 256-(ratio * 255)
      hex = dec.to_i.to_s(16)
      s=hex*3
      if s.size==3
        s *= 2
      end
      return "##{s}"
    end

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

  def preparegraph
    $people.each do |person|
      Graph::Node.new(person.pid)
      x = {}
      person.contact.each{|c| (x[c[0].pid] = c[1]) rescue nil}
      x.each do |p, d|
        Graph::Edge.new(person.pid, p, d)
      end
    end
    self
  end
  def printdot
    puts "graph G {"
    puts Graph::Node.rall.map(&:to_s)
    puts Graph::Edge.rall.map(&:to_s)
    puts "}"
    self
  end
  
end


if __FILE__ == $0
  Simulation.new.run.preparegraph.printdot
end
