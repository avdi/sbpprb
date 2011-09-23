# Debug Printing Method

# The Ruby equivalent to the VisualWorks displayString/printString
# split would be #to_s/#inspect.

# Association example:
class Association
  attr_accessor :key, :value

  def print_on(io)
    io.write key
    io.write '->'
    io.write value
  end
end

# For better or for worse, though, telling objects how to dump
# themselves to a stream isn't really Rubyish. We tend to tell objects
# how to stringify themselves instead.

class Association
  attr_accessor :key, :value

  def inspect
    "#{key}->#{value}"
  end
end
