namespace :check do

  desc "Runs inch to check quality of API docs"
  task :inch do
    puts "******* STARTING METRIC inch"
    Hexx::RSpec["inch --pedantic"]
    puts "******* ENDING METRIC inch"
  end
end
