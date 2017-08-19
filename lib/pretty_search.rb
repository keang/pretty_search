require 'yajl/json_gem'
require 'yajl'
require 'byebug'

require 'pretty_search/version'
require 'pretty_search/cli_options'
require 'pretty_search/query'
require 'pretty_search/collection'
require 'pretty_search/document'

module PrettySearch
  class MissingParameter < StandardError; end

  def self.run(query, data: nil, **options)
    if data.nil?
      raise MissingParameter, 'Data file is required, please pass in as --data'
    end
    collection = PrettySearch::Collection.load(data, options)
    found = collection.search(query)
    if found.empty?
      'No records found.'
    else
      found.join("\n")
    end
  end
end
