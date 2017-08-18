require 'json'
require 'pretty_search/version'
require 'pretty_search/cli_options'
require 'pretty_search/query'
require 'pretty_search/collection'
require 'pretty_search/document'

module PrettySearch
  class MissingParameter < StandardError; end

  def self.run(query, data: nil, **options)
    if data.nil?
      raise MissingParameter.new('Data file is required, please pass in as --data')
    end
    found = self.search(query, data, **options)
    puts found.join("\n")
  end

private

  # @return [Array<PrettySearch::Document>, #each]
  def self.search(query, data, **options)
    collection = PrettySearch::Collection.load(data)
    if options[:first]
      PrettySearch::Document.new collection.first { |doc| query.match(doc) }
    else
      collection.select { |doc| query.match(doc) }
        .map { |doc| PrettySearch::Document.new doc }
    end
  end
end
