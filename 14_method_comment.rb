# Method Comment

# Listing 1
if (flags & 0b1000) == 1        # Am I visible?
  # ...
end

# Listing 2
def visible?
  (flags & 0b1000) == 1
end

# Listing 3
if visible?
  # ...
end

# Listing 4
class Bin
  def run
    # Tell my station to process me
    station.process(self)
  end
end
