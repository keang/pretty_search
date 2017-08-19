module PrettySearch
  # PrettySearch::MemoryCollection parses the given data_file into hash
  # and keep everything in memory, and iterates through the records naively
  # from beginning to end when searching
  #
  class MemoryCollection < Collection
    def initialize(data_file)
      @data_file = data_file
    end

    def each(&block)
      data = Yajl::Parser.parse(File.new(@data_file))
      data.each(&block)
    end
  end
end
