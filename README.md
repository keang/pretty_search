# PrettySearch

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
`pretty_search --first -d users.json -q name:"Raylan Givens"`
`pretty_search --all -d users.json -q name:"Raylan Givens"`

### When you can throw RAM at your problem, and doing many searches:
`pretty_search -d users.json`
`pretty_search -q name:"Raylan Givens"`
`pretty_search -q tags:"Foxworth"`

### When you are poor on RAM/data is big:
`pretty_search --slim -d users.json`
`pretty_search -q name:"Raylan Givens"`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/keang/pretty_search. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

