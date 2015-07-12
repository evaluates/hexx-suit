$:.push File.expand_path("../lib", __FILE__)
require "hexx/suit/version"

Gem::Specification.new do |gem|

  gem.name        = "hexx-suit"
  gem.version     = Hexx::Suit::VERSION.dup
  gem.author      = "Andrew Kozin"
  gem.email       = "andrew.kozin@gmail.com"
  gem.homepage    = "https://github.com/hexx-rb/hexx-suit"
  gem.summary     = "Test/development suit."
  gem.description = "The module collects gems used for development and testing."
  gem.license     = "MIT"

  gem.files            = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.executables      = ["hexx-suit"]
  gem.test_files       = Dir["spec/**/*", "Rakefile", "Guardfile"]
  gem.extra_rdoc_files = Dir["LICENSE", "README.md", ".yardopts"]
  gem.extensions       = "ext/mkrf_conf.rb"

  gem.required_ruby_version = ">= 1.9.3"

  gem.add_runtime_dependency "fasterer", "~> 0.1"
  gem.add_runtime_dependency "guard-rspec", "~> 4.3"
  gem.add_runtime_dependency "hexx-rspec", "~> 0.5"
  gem.add_runtime_dependency "inch", "~> 0.5"
  gem.add_runtime_dependency "metric_fu", "~> 4.11"
  gem.add_runtime_dependency "pry-rescue", "~> 1.4"
  gem.add_runtime_dependency "rubocop", "~> 0.23"
  gem.add_runtime_dependency "yardstick", "~> 0.9"

  unless RUBY_ENGINE == "jruby"
    gem.add_runtime_dependency "pry-stack_explorer", "~> 0.4"
  end

  if RUBY_ENGINE == "ruby"
    if RUBY_VERSION < "2.0"
      gem.add_runtime_dependency "pry-debugger", "~> 0.2"
    else
      gem.add_runtime_dependency "pry-byebug", "~> 3.0"
    end
  end

  if RUBY_VERSION < "2.1"
    gem.add_runtime_dependency "mutant-rspec", "0.7.9"
    gem.add_runtime_dependency "mutant", "0.7.9"
    gem.add_runtime_dependency "rspec-core", "< 3.2.0"
  else
    gem.add_runtime_dependency "mutant-rspec", "~> 0.8"
  end

end
