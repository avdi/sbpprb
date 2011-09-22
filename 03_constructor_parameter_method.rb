# First example:
class Point
  attr_accessor :x, :y

  def initialize(x, y)
    self.x = x
    self.y = y
  end
end

# Second example
class Point
  attr_accessor :x, :y

  def initialize(x, y)
    set(x: x, y: y)
  end

  def set(options={})
    @x = options[:x]
    @y = options[:y]
    self
  end
end

# A closer analog would (re)define the .new class method, but arguably
# be less idiomatic ruby:
class Point
  attr_accessor :x, :y

  def self.new(x, y)
    new.set(x: x, y: y)
  end
  
  def set(options={})
    @x = options[:x]
    @y = options[:y]
    self
  end
end
