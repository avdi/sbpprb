# Intention Revealing Message

# Listing 1
class ParagraphEditor
  def highlight(rectangle)
    reverse(rectangle)
  end
end

# Alternate:

class ParagraphEditor
  alias_method :highlight, :reverse
end

# Listing 2
class Collection
  def empty?
    size.zero?
  end
end

class Number
  def reciprocal
    1 / self
  end
end

class Object
  def ==(other)
    equal?(other)
  end
end

