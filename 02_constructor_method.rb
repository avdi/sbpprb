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

# Except you could actually do this:

def Point(options)
  Point.new_polar(options[:r], options[:theta])
end

# And then with Ruby 1.9 you could call it like this:
#
#  Point r: a, theta: b
#
# :DDDDD
