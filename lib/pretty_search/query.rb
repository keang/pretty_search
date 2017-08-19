# @abstract
class PrettySearch::Query

  class InvalidQuery < StandardError; end


  # @return [PrettySearch::Query, #match]
  #
  def self.parse(args)
    parse_simple(args[0])
  end

  # @return [PrettySearch::SimpleQuery, #match]
  #
  def self.parse_simple(q_str)
    matches = /\A([\w ]+)=(.+)\z/.match q_str
    if matches && matches[1] && matches[2]
      value = matches[2].strip
      value = Integer(value) rescue value if value.is_a?(String)
      value = Float(value) rescue value if value.is_a?(String)
      value = true if value == 'true'
      value = false if value == 'false'
      return PrettySearch::SimpleQuery.new({ matches[1].strip => value})
    else
      raise InvalidQuery.new("Cannot understand query: #{q_str}")
    end
  end
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

  def [](key)
    attr[key]
  end

  # Used in specs
  def ==(o)
    attr == o.attr
  end
end
