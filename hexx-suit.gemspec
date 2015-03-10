$:.push File.expand_path("../lib", __FILE__)
require "hexx/suit/version"

Gem::Specification.new do |s|

  s.name        = "hexx-suit"
  s.version     = Hexx::Suit::VERSION.dup
  s.author      = "Andrew Kozin"
  s.email       = "andrew.kozin@gmail.com"
  s.homepage    = "https://github.com/nepalez/hexx-suit"
  s.summary     = "Test/development suit."
  s.description = "The module collects gems used for development and testing."
  s.license     = "MIT"

  s.files            = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  s.executables      = ["hexx-suit"]
  s.test_files       = Dir["spec/**/*", "Rakefile", "Guardfile"]
  s.extra_rdoc_files = Dir["LICENSE", "README.md", ".yardopts"]

  s.required_ruby_version = ">= 1.9.3"

  s.add_runtime_dependency "guard-rspec", "~> 4.3"
  s.add_runtime_dependency "hexx-rspec", "~> 0.0"
  s.add_runtime_dependency "inch", "~> 0.5"
  s.add_runtime_dependency "metric_fu", "~> 4.11"
  s.add_runtime_dependency "mutant-rspec", "~> 0.7"
  s.add_runtime_dependency "rubocop", "~> 0.23"
  s.add_runtime_dependency "yardstick", "~> 0.9"

end
