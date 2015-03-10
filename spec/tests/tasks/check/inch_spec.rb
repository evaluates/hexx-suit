# encoding: utf-8

describe "Rake::Task['check:inch']", :tasks do

  # The {#commands} variable is defined in the spec/support/config/tasks.rb
  # It collects the list of commands, that has been sent to system by
  # any instance of Hexx::RSpec::System utility.

  let(:task) { Rake::Task["check:inch"] }

  describe ".invoke", :sandbox do

    subject { try_in_sandbox { task.invoke } }

    it "runs inch metric" do
      expect { subject }.to change { commands }.to ["inch --pedantic"]
    end
  end
end
