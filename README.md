# PrettySearch

[![Build Status](https://travis-ci.org/keang/pretty_search.svg?branch=master)](https://travis-ci.org/keang/pretty_search)

- ruby 2.0.0 or newer

Searches given collection in json files and return human readable formats

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pretty_search'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pretty_search

## Usage

### When you can throw RAM at your problem, and only search once:
Return all records:

`pretty_search --data users.json name='Raylan Givens'`

Return only first record found:

`pretty_search --first --data users.json name='Raylan Givens'`

Chain queries, searching for records where `shared=false` *AND* `suspended=true`:

`pretty_search --first --data users.json shared=false suspended=true`

### [TODO] When you are poor on RAM or data is big:
`pretty_search --large-data users.json name='Raylan Givens'`

### [TODO] When you can throw RAM at your problem, and doing many searches:
`pretty_search --data users.json start`

`pretty_search name='Raylan Givens'`

`pretty_search tags='Foxworth'`

`pretty_search stop`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/keang/pretty_search. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## TODO
- For large file, read json file in chunk, and search on each chunk in memory
- A PrettySearch::CsvCollection to read csv (better for chunked searching)
- A PrettySearch::RedisCollection which load records onto a local redis for a persistent searching session, and using the index_field as redis key

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

