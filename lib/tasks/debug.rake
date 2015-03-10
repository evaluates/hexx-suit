caller = Hexx::RSpec::System

desc "Runs a test suit in a bundle environment inside pry 'rescue' wrapper."
task :debug do
  caller.call "bundle exec rescue rspec spec"
end
