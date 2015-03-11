require "rubygems"
require "rubygems/command.rb"
require "rubygems/dependency_installer.rb"

begin
  Gem::Command.build_args = ARGV
  rescue NoMethodError
end

inst = Gem::DependencyInstaller.new

begin

  if RUBY_ENGINE == "ruby"
    inst.install "pry-byebug", "~> 3.0" unless RUBY_VERSION < "2.0"
    inst.install "pry-debugger", "~> 0.2"   if RUBY_VERSION < "2.0"
    inst.install "pry-rescue", "~> 1.4"
    inst.install "pry-stack_explorer", "~> 0.4"
  end

rescue
  exit(1)
end

filename = File.join(File.dirname(__FILE__), "Rakefile")
File.write filename, "task :default\n"
