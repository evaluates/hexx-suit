# encoding: utf-8
begin
  require "bundler/setup"
rescue LoadError
  puts "You must `gem install bundler` and `bundle install` to run rake tasks"
  exit
end

# Loads bundler tasks
Bundler::GemHelper.install_tasks

# Loads the Hexx::RSpec and its tasks
require "hexx-rspec"
Hexx::RSpec.install_tasks

# Sets the Hexx::RSpec :test task to default
task default: :test
