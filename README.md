# Hexx::Suit

[![Gem Version](https://img.shields.io/gem/v/hexx-suit.svg?style=flat)][gem]
[![Build Status](https://img.shields.io/travis/nepalez/hexx-suit/master.svg?style=flat)][travis]
[![Dependency Status](https://img.shields.io/gemnasium/nepalez/hexx-suit.svg?style=flat)][gemnasium]
[![Coverage](https://img.shields.io/coveralls/nepalez/hexx-suit.svg?style=flat)][coveralls]
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](file:LICENSE)

[gem]: https://rubygems.org/gems/hexx-suit
[travis]: https://travis-ci.org/nepalez/hexx-suit
[gemnasium]: https://gemnasium.com/nepalez/hexx-suit
[codeclimate]: https://codeclimate.com/github/nepalez/hexx-suit
[coveralls]: https://coveralls.io/r/nepalez/hexx-suit

The module collects the test/development suit to be shared among projects, along with base settings for included packages.

It also defines a set of Rake tasks.

## Installation

Add this line to your application's Gemfile:

```ruby
group :test, :development do
  gem "hexx-rspec"
  gem "hexx-suit", require: false
end
```

Then execute:

```
bundle
```

And run the task from the application root:

```
hexx-suit install
```

Require the `hexx-rspec` part of the gem in the `spec_helper.rb` **before** loading application:

```ruby
# spec/spec_helper.rb
require "hexx-rspec"

# Loads coveralls runtime metrics
Hexx::RSpec.load_metrics_for(self)

require "my_app"
```

You can configure all metrics separately in a corresponding yml files, that are created at `config/metrics` directory. The directory also contains default STYLEGUIDE. Feel free to adapt it to your needs.

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
* [pry-byebug](https://github.com/deivid-rodriguez/pry-byebug)
* [pry-rescue](https://github.com/ConradIrwin/pry-rescue)
* [pry-stack-explorer](https://github.com/pry/pry-stack_explorer)

### Tools for Tasks Authomation

* [rake](https://github.com/ruby/rake) - a Ruby command line interface (CLI).

### Code Metrics

* [rubocop](https://github.com/bbatsov/rubocop) - a Ruby static code analyzer
* [metric_fu](https://github.com/metricfu/metric_fu/) - a collection of Ruby code analyzers.

### Documentation Tools

* [yard](https://yardoc.org/) - a Ruby documentation tool.
* [inch](https://trivelop.de/inch/) - a documentation measurement tool.
* [yardstick](https://github.com/dkubb/yardstick) - a tool that verifies documentation coverage of Ruby code

## Compatibility

Tested under rubies API 1.9.3+:

* MRI 1.9.3+
* Rubinius 2+ (1.9 and 2.0 modes)
* JRuby 1.7+ (1.9 and 2.0+ modes)

RSpec 3.0+ used for testing via [hexx-rspec] suit.

[hexx-rspec]: https://github.com/nepalez/hexx-rspec

## Latest Changes

### v1.0.0

* Pippi metric removed as incompatible to rubies 1.9.3
* 'hexx-rspec' module extracted to separate gem.
  
  It is now possible using 'hexx-suit' with the `require: false` key.

## Contributing

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with Rakefile or version
  (if you want to have your own version, that is fine but bump version
  in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## License

See [MIT LICENSE](file: LICENSE).
