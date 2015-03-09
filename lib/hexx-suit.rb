# Loads the parts of the suit to be available.
%w(i18n pry rake rspec thor yaml).each { |gem| require gem }

# Loads the code (the order is significant)
Dir.chdir File.expand_path("../..", __FILE__) do
  Dir[
    "./config/initializers/*.rb",
    "./lib/hexx/suit/utils/*.rb",
    "./lib/hexx/suit/metrics.rb",
    "./lib/hexx/suit/*.rb",
    "./lib/hexx/suit.rb"
  ].each { |file| require file }
end
