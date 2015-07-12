# Hexx::Suit   [![Documentation Status](https://readthedocs.org/projects/hexx-suit/badge/?version=latest)][readthedocs]

[![Gem Version](https://img.shields.io/gem/v/hexx-suit.svg?style=flat)][gem]
[![Build Status](https://travis-ci.org/hexx-rb/hexx-suit.svg?branch=master)][travis]
[![Dependency Status](https://img.shields.io/gemnasium/hexx-rb/hexx-suit.svg?style=flat)][gemnasium]
[![Code Climate](https://img.shields.io/codeclimate/github/hexx-rb/hexx-suit.svg?style=flat)][codeclimate]
[![Coverage](https://img.shields.io/coveralls/hexx-rb/hexx-suit.svg?style=flat)][coveralls]
[![Inline docs](http://inch-ci.org/github/hexx-rb/hexx-suit.svg)][inch]

[readthedocs]: http://hexx-suit.readthedocs.org
[gem]: https://rubygems.org/gems/hexx-suit
[travis]: https://travis-ci.org/hexx-rb/hexx-suit
[gemnasium]: https://gemnasium.com/hexx-rb/hexx-suit
[codeclimate]: https://codeclimate.com/github/hexx-rb/hexx-suit
[coveralls]: https://coveralls.io/r/hexx-rb/hexx-suit
[inch]: https://inch-ci.org/github/hexx-rb/hexx-suit

The module collects the test/development suit to be shared among projects, along with base settings for included packages.

It also defines a set of Rake tasks.

## Installation

Add this lines to your application's Gemfile:

```ruby
gem "hexx-rspec", group: %w(test development)
gem "hexx-suit",  group: :metrics, if RUBY_VERSION == "ruby"
```

Then execute:

```
bundle
```

And run the task from the application root:

```
hexx-suit install
```

You can configure all metrics separately in a corresponding yml files, that are created at `config/metrics` directory. The directory also contains default STYLEGUIDE. Feel free to adapt it to your needs.

In a [`.travis.yml`][Travis settings] it is recommended to exclude metrics from the build with option:

```yaml
bundler_args: --without metrics
```

[Travis settings]: http://docs.travis-ci.com/user/languages/ruby/#Dependency-Management

## Usage

The gem adds three tasks for a development process authomation:

### Test

The task runs rspec (runs no coverage controls) **in a bundle environment**.

```
rake test
```

This is a simple shortcut for longer syntaxes:

```
bundle exec rspec spec
```

You can also check test coverage:

```
rake test:coverage
```

### Debug

The tasks runs specs wrapped to pry `rescue` command.

```
rake debug
```

This is the same as:

```
bundle exec rescue rspec spec
```

### Check

The task runs rspec under the test coverage control, and then calls all the code metrics, except for mutation testing.

```
rake check
```

You can use single metrics as well:

```
rake check:yardstick
```

See all tasks at:

```
rake -T check
```

All the tasks will use settings from `config/metrics` folder.

## Package content

The gem loads dependencies from the projects below.

### Tools for Testing

* [rspec v3.0+](http://rspec.info/) - a Ruby test framework.
* [guard-rspec](https://github.com/guard/guard-rspec) - an authomatic tests launcher.
* [coveralls](https://coveralls.io/) - a tool for the test coverage control.
* [mutant](https://github.com/mbj/mutant) - a Ruby mutation testing.

### Tools for Debugging

* [pry](https://github.com/pry/pry/wiki) - a Ruby development console and debugging tool.
* [pry-rescue](https://github.com/ConradIrwin/pry-rescue)
* [pry-stack-explorer](https://github.com/pry/pry-stack_explorer)
* [pry-byebug](https://github.com/deivid-rodriguez/pry-byebug) for MRI 2.0+
* [pry-debugger](https://github.com/nixme/pry-debugger) for MRI 1.9.3

### Tools for Tasks Authomation

* [rake](https://github.com/ruby/rake) - a Ruby command line interface (CLI).

### Code Metrics

* [rubocop](https://github.com/bbatsov/rubocop) - a Ruby static code analyzer
* [metric_fu](https://github.com/metricfu/metric_fu/) - a collection of Ruby code analyzers.
* [fasterer](https://github.com/DamirSvrtan/fasterer) - a static code analyzer for suboptimal code.

### Documentation Tools

* [yard](https://yardoc.org/) - a Ruby documentation tool.
* [inch](https://trivelop.de/inch/) - a documentation measurement tool.
* [yardstick](https://github.com/dkubb/yardstick) - a tool that verifies documentation coverage of Ruby code

## Compatibility

Tested under [MRI rubies 1.9.3+](.travis.yml).

Uses [RSpec] 3.0+ for testing via [hexx-rspec] suit.

[RSpec]: http://rspec.info
[hexx-rspec]: https://github.com/hexx-rb/hexx-rspec

## Contributing

* Read the [STYLEGUIDE](config/metrics/STYLEGUIDE)
* [Fork the project](https://github.com/hexx-rb/hexx-suit)
* Create your feature branch (`git checkout -b my-new-feature`)
* Add tests for it
* Commit your changes (`git commit -am '[UPDATE] Add some feature'`)
* Push to the branch (`git push origin my-new-feature`)
* Create a new Pull Request

## License

See [MIT LICENSE](file: LICENSE).
