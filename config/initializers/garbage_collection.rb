# Delays garbage collection until the end of testing.
RSpec.configure do |config|

  config.before(:each) do
    GC.disable
  end

  config.after(:each) do
    GC.enable
  end
end
