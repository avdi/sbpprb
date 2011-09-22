# This pattern is common in ActiveSupport, e.g. 
# 
#   2.days.ago
#

class Point
  attr_accessor :x, :y
end

class Integer
  def by(y)
    Point.new.tap do |p|
      p.x = self
      p.y = y
    end
  end
end

4.by(5) # => #<Point:0x90eb420 @x=4, @y=5>

