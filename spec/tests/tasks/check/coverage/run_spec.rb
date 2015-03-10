# encoding: utf-8

describe "Rake::Task['check:coverage:run']", :tasks do

  # The {#commands} variable is defined in the spec/support/config/tasks.rb
  # It collects the list of commands, that has been sent to system by
  # any instance of Hexx::RSpec::System utility.

  let(:metric) { Hexx::RSpec::Metrics::SimpleCov }
  let(:task)   { Rake::Task["check:coverage:run"] }

  describe ".invoke", :sandbox do

    subject { try_in_sandbox { task.invoke } }

    it "loads the metric" do
      expect(metric).to receive(:load)
      subject
    end

    it "runs tests" do
      expect { subject }.to change { commands }.to ["rake test"]
    end
  end
end
