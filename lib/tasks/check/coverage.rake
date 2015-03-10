namespace :check do
  namespace :coverage do

    metric = Hexx::RSpec::Metrics::SimpleCov
    caller = Hexx::RSpec::System
    output = -> { ENV.fetch("SIMPLECOV_OUTPUT") { "coveralls/index.html" } }

    # Loads settings for simplecov from the '.hexx-suit.yml'
    task :configure do
      metric.load
    end

    desc "Runs tests under the coveralls"
    task run: :configure do
      caller.call "rake test"
      puts "see results in #{ output.call }"
    end

    desc "Displays results of the coveralls last run"
    task display: :configure do
      caller.call "launchy #{ output.call }"
    end
  end

  desc "Runs tests under the coveralls and displays the results"
  task coverage: %w(coverage:run coverage:display)
end
