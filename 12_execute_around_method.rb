# Execute Around Method

# This one is a core Ruby idiom.

# File os opened and closed around the block.
open('myfile') do |f|
  # ... do something with the file ...
end

# Cursor example:
class Cursor
  def show_while
    old = Cursor.current_cursor
    show
    yield
    old.show
  end
end

# With ensure:
class Cursor
  def show_while
    old = Cursor.current_cursor
    show
    yield
  ensure
    old.show
  end
end
