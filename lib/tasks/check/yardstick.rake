namespace :check do
  namespace :yardstick do

    metric = Hexx::Suit::Metrics::Yardstick
    output = lambda do
      ENV.fetch("YARDSTICK_OUTPUT") { "tmp/yardstick/results.log" }
    end

    desc "Runs yardstick metric"
    task :run do
      puts "******* STARTING METRIC yardstick"
      metric.run
      puts "see results in #{output.call}"
      puts "******* ENDING METRIC yardstick"
    end

    desc "Displays the results of yardstick last run"
    task :display do
      puts "******* DISPLAYING METRIC yardstick"
      metric.load
      Hexx::RSpec["cat #{output.call}"]
      puts "******* ENDING METRIC yardstick"
    end
  end

  desc "Runs yardstick metric and displays the results"
  task yardstick: %w(yardstick:run yardstick:display)
end
