guard :rspec, cmd: "bundle exec rspec" do

  watch("bin/hexx-suit") { "spec/tests/bin/install_spec.rb" }

  watch(%r{^lib/tasks/(.+)\.rb$}) do |m|
    [
      "spec/tests/tasks/#{ m[1] }_spec.rb",
      "spec/tests/tasks/#{ m[1] }/**/*_spec.rb"
    ]
  end

  watch(%r{^lib/hexx/suit/(.+)\.rb$}) do |m|
    "spec/tests/lib/#{ m[1] }_spec.rb"
  end

  watch(%r{^lib/hexx/suit/(.+)/base\.rb$}) do |m|
    "spec/tests/lib/#{ m[1] }/*_spec.rb"
  end

  watch("lib/hexx/suit.rb") { "spec" }

  watch("lib/hexx-suit.rb") { "spec" }

  watch(/^spec.+_spec\.rb$/)

  watch(%r{^spec/support/(.+)\.rb$}) { "spec" }

  watch("spec/spec_helper*.rb") { "spec" }
end
