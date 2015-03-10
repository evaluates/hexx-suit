# Loads the RSpec support files.
require "hexx-rspec"

# Loads support files
Dir.chdir(File.expand_path("..", __FILE__)) do
  Dir["./support/**/*.rb"].each { |file| require file }
end

# Loads coveralls runtime metrics
Hexx::RSpec.load_metrics_for(self)

require "hexx-suit"
