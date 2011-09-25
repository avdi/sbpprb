# Smalltalk-esque flow control is possible in Ruby.

module FlowControl
  TRUTHY = ->(value){value}
  FALSY  = ->(value){!value}
  
  def if_true
    yield if self == true
  end

  def if_false
    yield if self == false
  end

  # More practical:
  def if_truthy
    yield if self
  end

  def if_falsy
    yield unless self
  end

  
  def switch(cases={})
    # Note: Correct semantics require Ruby 1.9's ordered hashes.
    cases.each do |pattern, action|
      Array(pattern).any?{|p| p === self}.if_truthy do
        return action.call
      end
    end
    cases.fetch(:default){ ->{self} }.call
  end
end

class Object
  include FlowControl
end

true.if_true { puts "true is true!" }
false.if_false { puts "false is false!" }
nil.if_falsy { puts "nil is falsy!" }
nil.if_false { puts "nil is false" }

23.if_true { puts "23 is true" }
23.if_truthy { puts "23 is truthy" }

# Possible. But not always pretty.
[123, :foo, nil, "bar", "42", (1..5)].each do |it|
  it.switch(Numeric        => -> { puts "#{it} is numeric" },
            :foo           => -> { puts "#{it} is :foo" },
            FALSY          => -> { puts "#{it} is falsy" },
            ["foo", "bar"] => -> { puts "#{it} is foo or bar" },
            String         => -> { puts "#{it} is a string" },
            :default       => -> { puts "#{it} is none of the above" })
end

# It's fun to play with, but it gets into the realm of "cutting
# against the grain". Pretty soon you have to ask the question: if I
# want to do it this way, why am I not coding in Smalltalk, Self, or
# Io?
