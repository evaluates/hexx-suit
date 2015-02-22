$:.push File.expand_path("../lib", __FILE__)
require "hexx/suit/version"

Gem::Specification.new do |s|
  s.name        = "hexx-suit"
  s.version     = Hexx::Suit::VERSION.dup
  s.author      = "Andrew Kozin"
  s.email       = "andrew.kozin@gmail.com"
  s.homepage    = "https://github.com/nepalez/hexx"
  s.summary     = "Test/development suit."
  s.description = "The module collects gems used for development and testing."
  s.license     = "MIT"
  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = "~> 2.1"

  s.files            = Dir["config/**/*", "lib/**/*", ".rubocop.yml"]
  s.executables      = ["hexx-suit"]
  s.test_files       = Dir["spec/**/*", "Rakefile", "Guardfile"]
  s.extra_rdoc_files = Dir["LICENSE", "README.md", ".yardopts"]

  s.add_runtime_dependency "coveralls", "~> 0.7"
  s.add_runtime_dependency "guard-rspec", "~> 4.3"
  s.add_runtime_dependency "i18n", "~> 0.7"
  s.add_runtime_dependency "inch", "~> 0.5"
  s.add_runtime_dependency "metric_fu", "~> 4.11"
  s.add_runtime_dependency "mutant", "~> 0.7.6"
  s.add_runtime_dependency "pippi", "~> 0.0"
  s.add_runtime_dependency "pry", "~> 0.10"
  s.add_runtime_dependency "pry-byebug", "~> 2.0"
  s.add_runtime_dependency "pry-rescue", "~> 1.4"
  s.add_runtime_dependency "pry-stack_explorer", "~> 0.4"
  s.add_runtime_dependency "rake", "~> 10.3"
  s.add_runtime_dependency "rspec", "~> 3.0"
  s.add_runtime_dependency "rubocop", "~> 0.23"
  s.add_runtime_dependency "thor", "~> 0.19"
  s.add_runtime_dependency "yardstick", "~> 0.9"
end
