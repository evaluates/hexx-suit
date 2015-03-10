namespace :check do
  namespace :fu do

    metric = Hexx::Suit::Metrics::MetricFu
    caller = Hexx::RSpec::System
    output = -> { ENV.fetch("METRIC_FU_OUTPUT") { "tmp/metric_fu/output" } }

    # configures the metrics
    task :configure do
      metric.load
    end

    desc "Runs metric_fu"
    task run: :configure do
      caller.call "metric_fu --no-open --out #{ output.call }"
      puts "see results in #{ output.call }"
    end

    desc "Displays results of metric_fu last run"
    task display: :configure do
      caller.call "metric_fu --open --out #{ output.call }"
    end
  end

  desc "Runs metric_fu and displays the results"
  task fu: %w(fu:display)
end
