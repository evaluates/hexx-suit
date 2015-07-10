# encoding: utf-8

describe "Rake::Task['check:fu:display']", :tasks do

  let(:metric) { Hexx::Suit::Metrics::MetricFu  }
  let(:task)   { Rake::Task["check:fu:display"] }

  describe ".invoke", :sandbox, :capture do

    let(:subject) { try_in_sandbox { task.invoke } }

    it "loads the metric" do
      expect(metric).to receive(:load)
      subject
    end

    context "without metric_fu.yml" do

      it "opens the metric" do
        expect { subject }
          .to change { commands }
          .to ["metric_fu --open --out tmp/metric_fu"]
      end
    end

    context "with metric_fu.yml" do

      let(:options) { { "output" => "custom" } }
      before { prepare_settings options, "config/metrics/metric_fu.yml" }

      it "uses custom output" do
        expect { subject }
          .to change { commands }
          .to ["metric_fu --open --out custom"]
      end
    end
  end
end
