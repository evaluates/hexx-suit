# encoding: utf-8

describe "Rake::Task['check:yardstick:display']", :tasks do

  let(:metric) { Hexx::Suit::Metrics::Yardstick }
  let(:task)   { Rake::Task["check:yardstick:display"] }

  describe ".invoke", :sandbox, :capture do

    subject { try_in_sandbox { task.invoke } }

    context "when '.metrics.yml' is absent" do

      it "loads the metric" do
        expect(metric).to receive :load
        subject
      end

      it "prepares the output file and displays it" do
        expect { subject }.to change { commands }.to [
          "mkdir tmp/yardstick -p",
          "touch tmp/yardstick/output.log",
          "cat tmp/yardstick/output.log"
        ]
      end
    end

    context "when '.metrics.yml' is present" do

      let(:options) { { "output" => "custom/yardstick.log" } }
      before { prepare_settings options, "config/metrics/yardstick.yml" }

      it "loads the metric" do
        expect(metric).to receive :load
        subject
      end

      it "uses the output" do
        expect { subject }.to change { commands }.to [
          "mkdir custom -p",
          "touch custom/yardstick.log",
          "cat custom/yardstick.log"
        ]
      end
    end
  end
end
