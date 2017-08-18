require 'getoptlong'

module PrettySearch
  class InvalidQuery < StandardError; end

  class << self

    # @return [Hash] like:
    #   {
    #     help: [bool],
    #     data: [string],
    #   }
    #
    def parse_cli_opts
      abort 'Ruby 1.9.3 or newer is required' unless defined?(GetoptLong)
      cli_opts = GetoptLong.new(
        [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
        [ '--data', '-d', GetoptLong::REQUIRED_ARGUMENT ],
      )
      options = {}
      cli_opts.each do |option, args|
        # args is "" for options without an argument
        options[option[2..-1].to_sym] = args == "" ? true : args
      end
      options
    end

    def parse_query(args)
      parse_single_field(args[0])
    end

  private

    # @return [Hash] like:
    #   {
    #     [String] field_name => [String] value_to_match,
    #     ...
    #   }
    #
    def parse_single_field(q_str)
      matches = /\A([\w ]+)=(.+)\z/.match q_str
      if matches && matches[1] && matches[2]
        value = matches[2].strip
        value = Integer(value) rescue value
        value = true if value == 'true'
        value = false if value == 'false'
        return { matches[1].strip => value}
      else
        raise InvalidQuery.new("Cannot understand query: #{q_str}")
      end
    end

  end

  HELP_TEXT = <<~EOF
    pretty_search [OPTION] ... QUERY

    Example:
      pretty_search --data ./fixtures/users.json name='Raylan Givens'

    -h, --help:
       show help

    --data FILE, -d FILE:
       the file to search on
  EOF
end
