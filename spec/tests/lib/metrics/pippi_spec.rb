# encoding: utf-8
require "spec_helper"
require "pippi"

describe Hexx::Suit::Metrics::Pippi, :sandbox do

  shared_context "without pippi.yml" do
   
    let(:options) do
      { "checkset" => "basic", "output" => "tmp/pippi/output.log" }
    end 
  end

  shared_context "with pippi.yml" do

    let(:options) do
      { "checkset" => "training", "output" => "custom/pippi.log" }
    end

    before { prepare_settings options, "config/metrics/pippi.yml" }
  end

  shared_examples "environments loader" do

    before { ENV["USE_PIPPI"]    = nil }
    before { ENV["PIPPI_OUTPUT"] = nil }

    it "[sets USE_PIPPI]" do
      expect { subject }.to change { ENV["USE_PIPPI"] }.to "true"
    end

    it "[sets PIPPI_OUTPUT]" do
      expect { subject }.to change { ENV["PIPPI_OUTPUT"] }.to options["output"]
    end
  end

  shared_examples "file creator" do

    before { subject }

    it "[prepares the output file]" do
      expect(options["output"]).to be_present_in_sandbox
    end
  end

  shared_examples "metric runner" do

    after { subject }

    it "[runs the metric]" do
      expect(::Pippi::AutoRunner).to receive(:new) do |settings|
        expect(settings[:checkset]).to eq options["checkset"]
        expect(settings[:io]).to be_kind_of ::File
        expect(settings[:io].path).to eq options["output"]
      end
    end
  end

  describe ".load" do

    subject { try_in_sandbox { described_class.load } }

    context "when pippi.yml is absent" do

      include_context "without pippi.yml"

      it_behaves_like "environments loader"
      it_behaves_like "file creator"
    end

    context "when pippi.yml is present" do

      include_context "with pippi.yml"

      it_behaves_like "environments loader"
      it_behaves_like "file creator"
    end
  end

  describe ".run" do

    subject { try_in_sandbox { described_class.run } }

    context "when pippi.yml is absent" do

      include_context "with pippi.yml"

      it_behaves_like "environments loader"
      it_behaves_like "file creator"
      it_behaves_like "metric runner"
    end

    context "when pippi.yml is present" do

      include_context "without pippi.yml"

      it_behaves_like "environments loader"
      it_behaves_like "file creator"
      it_behaves_like "metric runner"
    end
  end
end
