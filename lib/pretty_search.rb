require 'json'
require 'pretty_search/version'
require 'pretty_search/cli_options'
require 'pretty_search/query'
require 'pretty_search/document'

module PrettySearch
  class MissingParameter < StandardError; end

  def self.run(query, data: nil, **options)
    if data.nil?
      raise MissingParameter.new('Data file is required, please pass in as --data')
    end
    t = self.search(query, data, **options)
    puts t
  end

private

  # @return [Array<PrettySearch::Document>, #each]
  def self.search(query, data, **options)
    collection = load_collection(data)
    if options[:first]
      PrettySearch::Document.new collection.first { |doc| query.match(doc) }
    else
      collection.select { |doc| query.match(doc) }
        .map { |doc| PrettySearch::Document.new doc }
    end
  end

  # @return [PrettySearch::Collection, #each]
  def self.load_collection(data)
    JSON.parse(File.read(data))
  end
end
