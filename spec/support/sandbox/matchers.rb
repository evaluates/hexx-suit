# encoding: utf-8

# Checks if a file with given name is present in sandbox.
#
# @example
#   expect("some_file.rb").to be_present_in_sandbox
RSpec::Matchers.define :be_present_in_sandbox do
  match do |filename|
    files = Dir[File.join(sandbox, filename)]
    expect(files).to be_any
  end
end

# Checks if a file with given name is absent in sandbox.
#
# @example
#   expect("some_file.rb").to be_absent_in_sandbox
RSpec::Matchers.define_negated_matcher(
  :be_absent_in_sandbox,
  :be_present_in_sandbox
)
