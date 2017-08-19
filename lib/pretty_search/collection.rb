module PrettySearch
  # @abstract
  # PrettySearch::Collection is the abstract class representing
  # a searchable collection of records.
  #
  # Implementations should include:
  #  - #search(PrettySearch::Query) returning Array<PrettySearch::Document>
  #
  # See implementations in lib/pretty_search/collection
  #
  class Collection
    # @return [PrettySearch::Collection, #search]
    # TODO: return IndexedCollection when multiple searches is supported
    #
    def self.load(data_file, options = {})
      PrettySearch::MemoryCollection.new(data_file, first: options[:first])
    end
  end
end

require 'pretty_search/collection/memory_collection'
require 'pretty_search/collection/indexed_collection'
