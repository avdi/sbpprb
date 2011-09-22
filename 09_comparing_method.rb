# Comparing Method

class Event
  include Comparable
  def <=>(other)
    timestamp <=> other.timestamp
  end
end
