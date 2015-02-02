# encoding: utf-8

# Loads the code of the module with the RSpec test suit.
require "hexx-suit"

# Loads runtime metrics in the current scope
Hexx::Suit.load_metrics_for self if ENV["USE_METRICS"]

# Loads the RSpec support files.
Dir[File.expand_path "spec/support/config/*.rb"].each { |file| require file }
