namespace :check do

  caller = Hexx::RSpec::System

  desc "Runs inch to check quality of API docs"
  task :inch do
    puts "******* STARTING METRIC inch"
    caller.call "inch --pedantic"
    puts "******* ENDING METRIC inch"
  end
end
