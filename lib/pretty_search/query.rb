# @abstract
class PrettySearch::Query

  class InvalidQuery < StandardError; end


  # @return [PrettySearch::Query, #match]
  #
  def self.parse(args)
    parse_simple(args)
  end

  # @return [PrettySearch::SimpleQuery, #match]
  #
  def self.parse_simple(q_strs)
    parsed_queries = {}
    q_strs.each do |q_str|
      matches = PrettySearch::SimpleQuery::SIMPLE_PATTERN.match q_str
      if matches && matches[1] && matches[2]
        value = matches[2].strip
        value = Integer(value) rescue value if value.is_a?(String)
        value = Float(value) rescue value if value.is_a?(String)
        value = true if value == 'true'
        value = false if value == 'false'
        parsed_queries[matches[1].strip] = value
      else
        raise InvalidQuery.new("Cannot understand query: #{q_str}")
      end
    end

    PrettySearch::SimpleQuery.new(parsed_queries)
  end
end

# Simple query that matches returns matches when all fields
# matches fully
class PrettySearch::SimpleQuery < PrettySearch::Query
  SIMPLE_PATTERN = /\A([\w ]+)=(.+)\z/.freeze

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
