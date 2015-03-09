source "https://rubygems.org"

gemspec

platforms :ruby do
  gem "pry-rescue", "~> 1.4"
  gem "pry-stack_explorer", "~> 0.4"
end

platforms :mri_19 do
  gem "pry-debugger", "~> 0.2"
end

platforms :mri_20, :mri_21, :mri_22 do
  gem "pry-byebug", "~> 3.0"
  gem "pippi", "~> 0.0"
end
