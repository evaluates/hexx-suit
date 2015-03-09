namespace :check do
  namespace :rubocop do

    metric  = Hexx::Suit::Metrics::Rubocop
    caller  = Hexx::Suit::Utils::System
    format  = -> { ENV.fetch("RUBOCOP_FORMAT") { "html" } }
    output  = -> { ENV.fetch("RUBOCOP_OUTPUT") { "tmp/rubocop/index.html" } }
    options = lambda do
      "-f #{ format.call } -o #{ output.call } -c config/metrics/rubocop.yml"
    end

    # Loads settings for rubocop metric from the '.hexx-suit.yml'
    task :configure do
      metric.load
    end

    desc "Runs rubocop metric"
    task run: :configure do
      puts "******* STARTING METRIC rubocop"
      caller.call "rubocop #{ options.call }"
      puts "see results in #{ output.call }"
      puts "******* ENDING METRIC rubocop"
    end

    desc "Displays the results of rubocop last run"
    task display: :configure do
      if format.call == "html"
        caller.call "launchy #{ output.call }"
      else
        puts "******* DISPLAYING METRIC rubocop"
        caller.call "cat #{ output.call }"
        puts "******* ENDING METRIC rubocop"
      end
    end
  end

  desc "Runs rubocop metric and displays the results"
  task rubocop: %w(rubocop:run rubocop:display)
end
