class Point
  attr_accessor :x, :y

  # Called as Point.new_polar(radius, theta)
  #
  # Ruby doesn't really have the syntax for:
  #
  #   Point r: a theta: b
  #
  def self.new_polar(radius, theta)
    allocate.tap do |p|
      p.x = radius * Math.cos(theta)
      p.y = radius * Math.sin(theta)
    end
  end
end

# From dbrock:
# Except you could actually do this:

def Point(options)
  Point.new_polar(options[:r], options[:theta])
end

# And then with Ruby 1.9 you could call it like this:
#
#  Point r: a, theta: b
#
# :DDDDD

# jacobthemyth
#   Point.new x: x, y: y
#   Point.new r: r, theta: t
class Point
  attr_reader :x, :y

  def self.new(options)
    allocate.tap do |p|
      begin
        p.x = options.fetch(:x)
        p.y = options.fetch(:y)
      rescue KeyError
        p.x = options[:r] * Math.cos(options[:theta])
        p.y = options[:r] * Math.sin(options[:theta])
      end
    end
  end
end
