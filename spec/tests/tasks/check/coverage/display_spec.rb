# encoding: utf-8

describe "Rake::Task['check:coverage:display']", :tasks do

  # The {#commands} variable is defined in the spec/support/config/tasks.rb
  # It collects the list of commands, that has been sent to system by
  # any instance of Hexx::RSpec::System utility.

  let(:metric) { Hexx::RSpec::Metrics::SimpleCov }
  let(:task)   { Rake::Task["check:coverage:display"] }

  describe ".invoke", :sandbox do

    subject { try_in_sandbox { task.invoke } }

    context "when '.metrics.yml' is absent" do

      it "loads the metric" do
        expect(metric).to receive(:load)
        subject
      end

      it "displays the default output" do
        expect { subject }.to change { commands }.to [
          "launchy tmp/coverage/index.html"
        ]
      end
    end

    context "when '.metrics.yml' is present" do

      let(:output) { "tmp/coverage" }
      before do
        prepare_settings "simplecov" => { "output" => output }
      end

      it "loads the metric" do
        expect(metric).to receive(:load)
        subject
      end

      it "uses the custom output folder" do
        expect { subject }.to change { commands }.to [
          "launchy #{ output }/index.html"
        ]
      end
    end
  end
end
