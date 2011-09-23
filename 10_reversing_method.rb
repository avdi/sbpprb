# Reversing Method

# There is an easy solution for the specific case of writing to an
# output stream. I'll put that at the end. First, I'll translate
# literally into Ruby.

# Example 1
class Point
  attr_accessor :x, :y

  def initialize(x, y)
    @x, @y = x, y
  end

  def print_on(stream)
    x.print_on(stream)
    stream.next_put_all(' @ ')
    y.print_on(stream)
  end
end

# Example 2
class Stream
  def print(object)
    object.print_on(self)
  end
end

class Point
  def print_on(stream)
    stream.print x
    stream.next_put_all ' @ '
    stream.print y
  end
end

# Of course, Ruby has no such thing as "Stream". It has a conventional
# notion of an 'IO-like' object, but no unifying module along the
# lines of Enumerable or Comparable which is included by all IO-like
# objects. More's the pity.

# We could put this functionality in a module, and include it into
# IO-likes as needed. We'll call it #print_obj since #print is already
# taken by IO-likes.

module ObjectPrinter
  def print_obj(object)
    object.print_on(self)
  end
end

class Point
  def print_on(io)
    io.print x
    io.print ' @ '
    io.print y
  end
end

$stdout.extend(ObjectPrinter)
p = Point.new(23,32)
p.print_on($stdout)
 

# However, for the specific case of handling output, Ruby has a
# solution which is concise and functionally equivalent to the
# Smalltalk example:

class Point
  def print_on(io)
    io << x << ' @ ' << y
  end
end

puts # blank line
p.print_on($stdout)
  
