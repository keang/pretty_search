require 'json'
require 'pretty_search/version'
require 'pretty_search/cli_options'
require 'pretty_search/query'
require 'pretty_search/document'

module PrettySearch
  class MissingParameter < StandardError; end

  def self.run(query, data:, **options)
    puts self.search(query, data, **options)
  end

private

  # @return [PrettySearch::Document, #each]
  def self.search(query, data, **options)
    collection = load_collection(data)
    if options[:first]
      collection.first { |doc| query.match(doc) }
    else
      collection.select { |doc| query.match(doc) }
    end
  end

  # @return [PrettySearch::Collection, #each]
  def self.load_collection(data)
    JSON.parse(File.read(data))
  end
end
