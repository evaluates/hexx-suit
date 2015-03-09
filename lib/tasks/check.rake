namespace :check do

  list = %w(coverage:run rubocop:run fu:run yardstick:run)
  desc "Runs all tests and code metrics"
  task run: (RUBY_VERSION < "2.0" ? list : ["pippi:run"].concat(list))

  list = %w(coverage:display rubocop:display fu:display inch yardstick:display)
  desc "Displays results of last run for any metric"
  task display: (RUBY_VERSION < "2.0" ? list : ["pippi:display"].concat(list))
end

list = %w(check:coverage check:rubocop check:fu check:inch check:yardstick)
unless RUBY_VERSION < "2.0"
  list = ["check:pippi:configure", list, "check:pippi:display"].flatten
end
desc "Runs all tests and code metrics and displays their results"
task check: list
