module PrettySearch
  # Example extension
  #
  # PrettySearch::IndexedCollection is like MemoryCollection, but builds
  # an index on a given field for faster searching. Ideal for multiple
  # searches when memory size is not an issue
  #
  class IndexedCollection < Collection
    def initialize(data_file, index_field: nil, first: false)
      if index_field.nil?
        raise MissingParameter.new('Field name to be indexed required')
      end
      data = Yajl::Parser.parse(File.new(data_file))
      @index_field = index_field
      @index = build_index(data, index_field)
    end

    def search(query)
      if query[@index_field].nil?
        raise "indexed field: \"#{@index_field}\" not used in query"
      end
      scoped = @index[query[@index_field]]
      scoped.select { |doc| query.match(doc) }
    end

  private

    def build_index(data, index_field)
      Hash.new([]).tap do |index|
        data.each do |doc|
          index[doc[index_field]] << doc
        end
      end
    end
  end
end
