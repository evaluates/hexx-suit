caller = Hexx::Suit::Utils::System

desc "Runs a test suit in a bundle environment, without monitoring coverage."
task :test do
  caller.call "bundle exec rspec spec"
end
