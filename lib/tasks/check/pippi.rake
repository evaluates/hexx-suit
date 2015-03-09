namespace :check do

  namespace :pippi do

    metric = Hexx::Suit::Metrics::Pippi
    caller = Hexx::Suit::Utils::System
    output = -> { ENV.fetch("PIPPI_OUTPUT") { "log/pippi.log" } }

    # Loads settings for pippi runtime metric from the '.hexx-suit.yml'
    task :configure do
      metric.load
    end

    desc "Runs tests with pippi runtime metric"
    task run: :configure do
      puts "******* STARTING METRIC pippi"
      caller.call "rake test"
      puts "see pippi results in #{ output.call }"
      puts "******* ENDING METRIC pippi"
    end

    desc "Displays results of pippi last run"
    task display: :configure do
      puts "******* DISPLAYING METRIC pippi"
      caller.call "cat #{ output.call }"
      puts "******* ENDING METRIC pippi"
    end
  end

  desc "Runs tests with pippi runtime metric and displays the results"
  task pippi: %w(pippi:run pippi:display)

end unless RUBY_VERSION < "2.0"
