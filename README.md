# GemSemver

This gem adds the `bump` command to your path so you can update the version of your gem using semantic versioning. It does not create commits, it just updates 

## Installation

Run this command in your terminal:

    $ gem install gem_semver

## Usage

```bump major```

Updates the major version number and resets the minor and patch version numbers to 0. Also creates a backup of the Gemfile.lock and the version.rb.

```bump minor```

Updates the minor version number and resets the patch version number to 0. Also creates a backup of the Gemfile.lock and the version.rb.

```bump patch```

Updates the patch version number. Also creates a backup of the Gemfile.lock and the version.rb.

```bump clean```

Removes the .bak files created by running any of the version bumps. The backups are created just in case of a power outage or accidental shutoff before the update completes. Once you're happy with 

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/<github username>/gem_semver. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GemSemver project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/<github username>/gem_semver/blob/master/CODE_OF_CONDUCT.md).
