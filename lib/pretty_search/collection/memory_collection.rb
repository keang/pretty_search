module PrettySearch
  # PrettySearch::MemoryCollection parses the given data_file into hash
  # and keep everything in memory, and iterates through the records naively
  # from beginning to end when searching
  #
  class MemoryCollection < Collection
    def initialize(data_file, first: false)
      @data_file = data_file
      @first = first
    end

    # @return [Array<PrettySearch::Document>]
    def search(query)
      data = Yajl::Parser.parse(File.new(@data_file))
      if @first
        found = data.detect { |doc| query.match(doc) }
        if found
          Array(PrettySearch::Document.new(found))
        else
          []
        end
      else
        data.select { |doc| query.match(doc) }
          .map { |doc| PrettySearch::Document.new doc }
      end
    end
  end
end
