# encoding: utf-8
require "spec_helper"
require "simplecov"

describe Hexx::Suit::Metrics::SimpleCov, :sandbox do

  shared_context "without simplecov.yml" do

    let(:options) do
      {
        "output"  => "tmp/coverage",
        "filters" => ["spec/", "config/"],
        "groups"  => {
          "Libraries" => "lib/",
          "Application" => "app/"
        }
      }
    end
  end

  shared_context "with simplecov.yml" do

    let(:options) do
      {
        "output"  => "custom",
        "filters" => ["custom/"],
        "groups"  => { "Custom" => "custom/" }
      }
    end

    before { prepare_settings options, "config/metrics/simplecov.yml" }
  end

  shared_examples "environmets setter" do

    before do
      ENV["USE_SIMPLECOV"]    = nil
      ENV["SIMPLECOV_OUTPUT"] = nil
    end

    it "[sets USE_SIMPLECOV]" do
      expect { subject }
        .to change { ENV["USE_SIMPLECOV"] }
        .to "true"
    end

    it "[sets SIMPLECOV_OUTPUT]" do
      expect { subject }
        .to change { ENV["SIMPLECOV_OUTPUT"] }
        .to "#{ options['output'] }/index.html"
    end
  end

  shared_examples "metric loader" do

    after { subject }

    it "starts the metric" do
      expect(::SimpleCov).to receive(:start)
    end
  end

  describe ".load" do

    subject { try_in_sandbox { described_class.load } }

    context "without simplecov.yml" do

      include_context "without simplecov.yml"

      it_behaves_like "environmets setter"
    end

    context "with simplecov.yml" do

      include_context "with simplecov.yml"

      it_behaves_like "environmets setter"
    end
  end

  describe ".run" do

    subject { try_in_sandbox { described_class.run } }

    context "without simplecov.yml" do

      include_context "without simplecov.yml"

      it_behaves_like "environmets setter"
      it_behaves_like "metric loader"
    end

    context "with simplecov.yml" do

      include_context "without simplecov.yml"

      it_behaves_like "environmets setter"
      it_behaves_like "metric loader"
    end
  end
end
