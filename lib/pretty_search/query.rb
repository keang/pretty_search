# @abstract
class PrettySearch::Query
  class InvalidQuery < StandardError; end

  EPSILON = 10**-10

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
        if value.is_a?(String)
          value = begin
                    Integer(value)
                  rescue
                    value
                  end
        end
        if value.is_a?(String)
          value = begin
                    Float(value)
                  rescue
                    value
                  end
        end
        value = true if value == 'true'
        value = false if value == 'false'
        parsed_queries[matches[1].strip] = value
      else
        raise InvalidQuery, "Cannot understand query: #{q_str}"
      end
    end

    PrettySearch::SimpleQuery.new(parsed_queries)
  end
end

# Simple query that matches returns matches when all fields
# matches fully
class PrettySearch::SimpleQuery < PrettySearch::Query
  SIMPLE_PATTERN = /\A([\w ]+)=(.+)\z/

  attr_reader :attr

  def initialize(attr)
    @attr = attr
  end

  def match(doc)
    attr.all? do |key, value|
      case doc[key]
      when Float
        (doc[key] - value).abs < EPSILON
      when Array
        doc[key].include? value
      else
        doc[key] == value
      end
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
