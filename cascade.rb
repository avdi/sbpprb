# In Smalltalk, you can "cascade" side-effectful calls to the same
# object using the semicolon (;) operator. E.g.:
#
#   aStream
#       print x;
#       nextPutOn ' @ ';
#       print y
#
# If I understand it correctly, the semicolon is effectively a
# K-combinator or "Kestrel" (see
# https://github.com/raganwald/homoiconic/blob/master/2008-10-29/kestrel.markdown#readme)
#
# I am jealous. Sure, we have tap, but that's awfully verbose by
# comparison:

x, y = 23, 32

$stdout.tap do |s| 
  s.print x     end.tap do |s| 
  s.print ' @ ' end.tap do |s| 
  s.print y
end

puts

# Let's see if we can do better for this simple case of cascading a
# series of commands, while ignoring their return values.

require 'delegate'
module Cascadable
  class CascadeProxy < BasicObject
    def initialize(object)
      @object = object
    end

    def method_missing(*args, &block)
      @object.send(*args, &block)
      return self
    end
  end

  def cascade
    return CascadeProxy.new(self)
  end
  alias_method :k, :cascade
end

class Object
  include Cascadable
end

$stdout.k.
  print(x).
  print(' @ ').
  print(y)

# Yay!
  
