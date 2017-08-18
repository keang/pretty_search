require 'yajl'

module PrettySearch
  # @abstract
  # PrettySearch::Collection is the abstract class representing
  # a searchable collection of records. Implementations should implement #each
  #
  class Collection
    include Enumerable

    # @return [PrettySearch::Collection, #each]
    def self.load(data_file)
      MemoryCollection.new(data_file, max_memory)
    end
  end

  # PrettySearch::MemoryCollection parses the given data_file into hash
  # and keep everything in memory, and iterates through the records naively
  # from beginning to end when searching
  #
  class MemoryCollection
    def initialize(data_file)
      @data_file = data_file
    end

    def each(&block)
      data = Yajl::Parser.parse(File.new(@data_file))
      data.each(&block)
    end
  end
end
