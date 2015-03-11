namespace :check do

  desc "Runs all tests and code metrics"
  task run: %w(test:coverage:run rubocop:run fu:run yardstick:run)

  desc "Displays results of last run for any metric"
  task display: %w(
    test:coverage:display
    rubocop:display
    fu:display
    inch
    yardstick:display
  )
end

desc "Runs all tests and code metrics and displays their results"
task check: %w(test:coverage check:rubocop check:fu check:inch check:yardstick)
