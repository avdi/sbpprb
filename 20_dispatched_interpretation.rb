# Dispatched Interpretation

# Listing 1
#
# Ruby doesn't have a good convention for methods which take more than
# one block. And of course it doesn't have keyword parameters. Here
# are a few takes on Smalltalk's #ifTrue:
#
# Listing 1 v1
class TrueClass
  def if_true(true_block, options={})
    true_block.call
  end
end

class FalseClass
  def if_true(true_block, options={})
    false_block = options[:if_false]
    false_block.call if false_block
  end
end

# Called like this:
object.if_true ->{puts "true!" }, if_false: ->{ puts "false!" }

# I don't really like this version.

# Listing 1 v2
class Object
  def if_false
    self
  end
end

class TrueClass
  def if_true
    yield
  end
end

class FalseClass
  def if_true
    self
  end

  def if_false
    yield
  end
end

# Called like this:
object.if_true{puts "true!"}.if_false{puts "false!"}

# Listing 2
#
# It's just the String#[] method in Ruby 1.9. If we really wanted to
# write out an implementation of String#at anyway, we might do it like
# this:

class String
  def at(index)
    getbyte(index).chr
  end
end


# Listing 3
class PostScriptShapePrinter
  def display(shape)
    (0...shape.size).each |i| do
      command = shape.command_at(i)
      arguments = shape.arguments_at(i)
      case command
      when :line
        print_point(arguments[0])
        space
        print_point(arguments[1])
        space
        print 'line' # next_put_all is not a very Rubyish method name
      when :curve
        # ...
      end
    end
  end
end

# Listing 4
class PostScriptShapePrinter
  def line(from_point, to_point)
    print_point(arguments[0])
    space
    print_point(arguments[1])
    space
    print 'line'
  end
end

# Listing 5
class PostScriptShapePrinter
  def display(shape)
    (0...shape.size).each do |i|
      shape.send_command_at_index_to_object(i, self)
    end
  end
end
  
# Listing 6
class Shape
  def send_commands_to(object)
    (0...size).each do |i|
      send_command_at_index_to_object(i, self)
    end
  end
end

# Listing 6 v2
#
# Note: A more idiomatic Ruby implementation would make a visitor
# method for the commands collection. Assuming this method (not shown)
# is called #each_command, the #send_commands_to code would look
# something like this:
class Shape
  def send_commands_to(object)
    each_command do |command, arguments|
      object.public_send(command, *arguments)
    end
  end
end
    
# Listing 7
class PostScriptShapePrinter
  def display(shape)
    shape.send_commands_to(self)
  end
end
