# Staying close to the example we get something like this:
class Date
  def self.from_string(string)
    # ...
  end
end

# But the built-in Date.parse() is basically the same thing:

require 'date'
Date.parse('2011-09-22')

# There is another Ruby idiom which may also qualify as embodying this
# pattern:

require 'pathname'
String(23)         # => "23"
Array(23)          # => [23]
Pathname(__FILE__) # => #<Pathname:->

