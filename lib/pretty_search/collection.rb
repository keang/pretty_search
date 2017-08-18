class PrettySearch::Collection
  # @return [PrettySearch::Collection, #each]
  def self.load(data)
    PrettySearch::MemoryCollection.new(JSON.parse(File.read(data)))
  end
end

class PrettySearch::MemoryCollection
  include Enumerable

  def initialize(data)
    @data = data
  end

  def each(&block)
    @data.each(&block)
  end
end
