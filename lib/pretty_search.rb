require "pretty_search/version"
require "pretty_search/cli_options"

module PrettySearch
  class MissingParameter < StandardError; end

  def self.run(query, data:, **options)
    pass
  end
end
