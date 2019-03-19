# RepoBot -- List Your Repositories

`repo-bot` extracts basic information from your repositories and outputs it as a comma-separated values (CSV) file. Currently it checks one GitHub account and on BitBucket account. Hopefully, this will be made more flexible in the near future.

## Installation

Or install it yourself as:

    $ gem install repo_bot

You could also use some of the code in another application. Add this line to your application's Gemfile:

```ruby
gem 'repo_bot'
```

And then execute:

    $ bundle

## Usage

```bash
usage: exe/repo-bot [options] [directory]
    -c, --csv      Output information in CSV format. This is the default.
    -h, --help     Show this help information
    -o, --output   Write the information to the specified file, instead of STDOUT (the terminal).
    -v, --version  Print the version of this program.
```

`repo-bot` will prompt you for your GitHub username and password, and your BitBucket username and password. If the following environment variables are set and exported, `repo-bot` will use the values in the environment variables and will not prompt you.

```bash
export GITHUB_USERNAME=<username>
export GITHUB_PASSWORD=<password>
export BITBUCKET_USERNAME=<username>
export BITBUCKET_PASSWORD=<password>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/repo_bot. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RepoBot project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/repo_bot/blob/master/CODE_OF_CONDUCT.md).
