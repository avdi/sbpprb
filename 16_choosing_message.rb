# Choosing Method

# Listing 1
responsible = if entry.kind_of?(Film)
                entry.producer
              else
                entry.author
              end

# Or:
responsible = entry.kind_of?(Film) ? entry.producer : entry.author

# Listing 2
class Film
  def responsible
    producer
  end
end

class Entry
  def responsible
    author
  end
end

# Or:
class Film
  alias_method :responsible, :producer
end

class Entry
  alias_method :responsible, :author
end

# Listing 3
responsible = entry.responsible

