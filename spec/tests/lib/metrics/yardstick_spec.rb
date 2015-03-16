# encoding: utf-8
require "spec_helper"
require "yardstick/rake/measurement"

describe Hexx::Suit::Metrics::Yardstick, :sandbox, :capture do

  shared_context "without yardstick.yml" do

    let(:options) do
      { "output"  => "tmp/yardstick/output.log", "path" => "lib/**/*.rb" }
    end
  end

  shared_context "with yardstick.yml" do

    let(:options) do
      { "output"  => "custom.log", "path" => "app/**/*.rb" }
    end

    before { prepare_settings options, "config/metrics/yardstick.yml" }
  end

  shared_examples "dependency loader" do

    after { subject }

    it "[loads yardstick/rake/measurement]" do
      expect(described_class).to receive(:require)
        .with("yardstick/rake/measurement")
    end
  end

  shared_examples "file creator" do

    before { subject }

    it "[prepares output file]" do
      expect(options["output"]).to be_present_in_sandbox
    end
  end

  shared_examples "environment setter" do

    before { ENV["YARDSTICK_OUTPUT"] = nil }

    it "sets ENV[YARDSTICK_OUTPUT] to default output" do
      expect { subject }
        .to change { ENV["YARDSTICK_OUTPUT"] }
        .to options["output"]
    end
  end

  shared_examples "metric runner" do

    after { subject }

    it "[runs yardstick]" do
      expect(::Yardstick::Rake::Measurement)
        .to receive_message_chain(:new, :yardstick_measure)
    end
  end

  describe ".load" do

    subject { try_in_sandbox { described_class.load } }

    context "when yardstick.yml is absent" do

      include_context "without yardstick.yml"

      it_behaves_like "dependency loader"
      it_behaves_like "file creator"
      it_behaves_like "environment setter"
    end

    context "when yardstick.yml is present" do

      include_context "with yardstick.yml"

      it_behaves_like "dependency loader"
      it_behaves_like "file creator"
      it_behaves_like "environment setter"
    end
  end

  describe ".run" do

    subject { try_in_sandbox { described_class.run } }

    context "when yardstick.yml is absent" do

      include_context "without yardstick.yml"

      it_behaves_like "dependency loader"
      it_behaves_like "file creator"
      it_behaves_like "environment setter"
      it_behaves_like "metric runner"
    end

    context "when yardstick.yml is present" do

      include_context "with yardstick.yml"

      it_behaves_like "dependency loader"
      it_behaves_like "file creator"
      it_behaves_like "environment setter"
      it_behaves_like "metric runner"
    end
  end
end
