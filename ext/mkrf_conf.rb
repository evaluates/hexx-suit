require "rubygems"
require "rubygems/command.rb"
require "rubygems/dependency_installer.rb"

begin
  Gem::Command.build_args = ARGV
  rescue NoMethodError
end

inst = Gem::DependencyInstaller.new

begin

  if RUBY_VERSION < "2.0"
    inst.install "pry-debugger", "~> 0.2"
  else
    inst.install "pry-byebug", "~> 3.0"
  end

rescue
  exit(1)
end

filename = File.join(File.dirname(__FILE__), "Rakefile")
File.write filename, "task :default\n"
