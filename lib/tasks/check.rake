namespace :check do

  desc "Runs all tests and code metrics"
  task run: %w(
    pippi:run
    coverage:run
    rubocop:run
    fu:run
    yardstick:run
  )

  desc "Displays results of last run for any metric"
  task display: %w(
    pippi:display
    coverage:display
    rubocop:display
    fu:display
    inch
    yardstick:display
  )
end

desc "Runs all tests and code metrics and displays their results"
task check: %w(
  check:pippi:configure
  check:coverage
  check:rubocop
  check:fu
  check:pippi:display
  check:inch
  check:yardstick
)
