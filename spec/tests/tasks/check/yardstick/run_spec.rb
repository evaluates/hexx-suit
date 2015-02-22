# encoding: utf-8

describe "Rake::Task['check:yardstick:run']", :tasks do

  let(:metric) { Hexx::Suit::Metrics::Yardstick }
  let(:task)   { Rake::Task["check:yardstick:run"] }

  describe ".invoke", :sandbox do

    subject { try_in_sandbox { task.invoke } }

    context "always" do

      it "runs the metric" do
        expect(metric).to receive(:run)
        subject
      end
    end
  end
end
