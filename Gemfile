source "https://rubygems.org"

gemspec

if %w(ruby rbx).include? RUBY_ENGINE
  gem "pry-rescue"
  gem "pry-stack_explorer"
end

if RUBY_ENGINE == "ruby"
  if RUBY_VERSION < "2.0"
    gem "pry-debugger"
  else
    gem "pry-byebug"
    gem "pippi"
  end
end
