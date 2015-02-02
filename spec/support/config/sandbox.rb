# encoding: utf-8

RSpec.configure do |config|

  # Prepares a sandbox before corresponding spec.
  config.before :each, :sandbox do
    require_relative "../sandbox/helpers"
    require_relative "../sandbox/matchers"
    prepare_sandbox
  end

  # Clears a sandbox after corresponding spec.
  config.after :each, :sandbox do
    clear_sandbox
  end
end
