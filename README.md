# Ashby

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add ashby
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install ashby
```

## Usage

First you will have to confige the gem. You need to setup an API token on Ashby. Once you've retrieved that, you are ready:

```ruby
Ashby.configure do |config|
  config.api_token = ENV.fetch('ASHBY_API_TOKEN', nil)
end
```

Then once you have the client setup, you can call the API. Some examples:

```ruby
Ashby::JobBoards.all
Ashby::Applications.find_by_id(application_id)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lienvdsteen/ashby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/lienvdsteen/ashby/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ashby project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/lienvdsteen/ashby/blob/main/CODE_OF_CONDUCT.md).
