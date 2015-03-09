namespace :check do

  list = %w(coverage:run rubocop:run fu:run yardstick:run)
  list = ["pippi:run", list].flatten if USE_PIPPI_METRIC
  desc "Runs all tests and code metrics"
  task run: list

  list = %w(coverage:display rubocop:display fu:display inch yardstick:display)
  list = ["pippi:display", list].flatten if USE_PIPPI_METRIC
  desc "Displays results of last run for any metric"
  task display: list
end

list = %w(check:coverage check:rubocop check:fu check:inch check:yardstick)
if USE_PIPPI_METRIC
  list = ["check:pippi:configure", list, "check:pippi:display"].flatten
end
desc "Runs all tests and code metrics and displays their results"
task check: list
