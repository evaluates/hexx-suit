desc "Runs a test suit in a bundle environment inside pry 'rescue' wrapper."
task :debug do
  Hexx::RSpec["bundle exec rescue rspec spec"]
end
