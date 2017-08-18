# @abstract
class PrettySearch::Query
end

# Simple query that matches returns matches when all fields
# matches fully
class PrettySearch::SimpleQuery < PrettySearch::Query
  attr_reader :attr
  def initialize(attr)
    @attr = attr
  end

  def match(doc)
    attr.all? do |key, value|
      doc[key] == value # floats are compared as strings
    end
  end

  # Used in specs
  def ==(o)
    attr == o.attr
  end
end
