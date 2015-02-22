# encoding: utf-8

describe "Rake::Task['check:fu:run']", :tasks do

  # The {#commands} variable is defined in the spec/support/config/tasks.rb
  # It collects the list of commands, that has been sent to system by
  # any instance of Hexx::Suit::Utils::System utility.

  let(:metric) { Hexx::Suit::Metrics::MetricFu  }
  let(:task)   { Rake::Task["check:fu:run"] }

  describe ".invoke", :sandbox do

    let(:subject) { try_in_sandbox { task.invoke } }

    it "loads the metric" do
      expect(metric).to receive(:load)
      subject
    end

    context "without metric_fu.yml" do

      it "runs the metric" do
        expect { subject }
          .to change { commands }
          .to ["metric_fu --no-open --out tmp/metric_fu"]
      end
    end

    context "with metric_fu.yml" do

      let(:options) { { "output" => "custom" } }
      before { prepare_settings options, "config/metrics/metric_fu.yml" }

      it "uses custom output" do
        expect { subject }
          .to change { commands }
          .to ["metric_fu --no-open --out custom"]
      end
    end
  end
end