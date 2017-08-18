require 'getoptlong'

module PrettySearch
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
