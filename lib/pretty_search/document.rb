class PrettySearch::Document
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def to_str
    JSON.pretty_generate(data)
  end
end
