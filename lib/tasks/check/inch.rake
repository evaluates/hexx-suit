namespace :check do

  caller = Hexx::Suit::Utils::System

  desc "Runs inch to check quality of API docs"
  task :inch do
    puts "******* STARTING METRIC inch"
    caller.call "inch --pedantic"
    puts "******* ENDING METRIC inch"
  end
end
