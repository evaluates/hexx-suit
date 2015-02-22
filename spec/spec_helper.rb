# encoding: utf-8

# Loads the code of the module with the RSpec test suit.
require "hexx-suit"

# Loads the RSpec support files.
Dir[File.expand_path "spec/support/config/*.rb"].each { |file| require file }

# Loads runtime metrics in the current scope
ENV["USE_SIMPLECOV"] = "true"
Hexx::Suit.load_metrics_for self
