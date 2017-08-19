module PrettySearch
  # @abstract
  # PrettySearch::Collection is the abstract class representing
  # a searchable collection of records. Implementations should implement #each
  # See implementations in lib/pretty_search/collection
  #
  class Collection
    include Enumerable

    # @return [PrettySearch::Collection, #each]
    def self.load(data_file)
      PrettySearch::MemoryCollection.new(data_file)
    end
  end
end

require 'pretty_search/collection/memory_collection'
