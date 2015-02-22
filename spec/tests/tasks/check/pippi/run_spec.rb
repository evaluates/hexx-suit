# encoding: utf-8

describe "Rake::Task['check:pippi:run']", :tasks do

  # The {#commands} variable is defined in the spec/support/config/tasks.rb
  # It collects the list of commands, that has been sent to system by
  # any instance of Hexx::Suit::Utils::System utility.

  let(:metric) { Hexx::Suit::Metrics::Pippi }
  let(:task)   { Rake::Task["check:pippi:run"] }

  describe ".invoke", :sandbox do

    subject { try_in_sandbox { task.invoke } }

    it "loads the metric" do
      expect(metric).to receive(:load)
      subject
    end

    it "runs tests" do
      expect { subject }.to change { commands.include? "rake test" }.to true
    end
  end
end
