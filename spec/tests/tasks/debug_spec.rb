# encoding: utf-8

describe "Rake::Task[:debug]", :tasks do

  # The {#commands} variable is defined in the spec/support/config/tasks.rb
  # It collects the list of commands, that has been sent to system by
  # any instance of Hexx::RSpec::System utility.

  let(:task) { Rake::Task[:debug] }

  describe ".invoke", :sandbox, :capture do

    subject { try_in_sandbox { task.invoke } }

    it "runs tests under pry rescue" do
      expect { subject }.to change { commands }.to [
        "bundle exec rescue rspec spec"
      ]
    end
  end
end
