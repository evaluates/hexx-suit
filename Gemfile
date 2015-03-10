source "https://rubygems.org"

gemspec

platforms :ruby do
  gem "pry-rescue", "~> 1.4", require: true
  gem "pry-stack_explorer", "~> 0.4", require: true
end

platforms :mri_19 do
  gem "pry-debugger", "~> 0.2", require: true
end

platforms :mri_20, :mri_21 do
  gem "pry-byebug", "~> 3.0", require: true
end
