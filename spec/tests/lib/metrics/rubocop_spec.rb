# encoding: utf-8
require "spec_helper"

describe Hexx::Suit::Metrics::Rubocop, :sandbox, :capture do

  shared_context "without rubocop.yml" do

    let(:options) do
      { "output" => "tmp/rubocop/index.html", "format" => "html" }
    end
  end

  shared_context "with rubocop.yml" do

    let(:options) do
      { "output" => "custom/rubocop.html", "format" => "custom" }
    end

    before { prepare_settings options, "config/metrics/rubocop.yml" }
  end

  shared_examples "environments loader" do

    before { ENV["RUBOCOP_OUTPUT"] = nil }
    before { ENV["RUBOCOP_FORMAT"] = nil }

    it "[sets RUBOCOP_OUTPUT]" do
      expect { subject }
        .to change { ENV["RUBOCOP_OUTPUT"] }
        .to options["output"]
    end

    it "[sets RUBOCOP_FORMAT]" do
      expect { subject }
        .to change { ENV["RUBOCOP_FORMAT"] }
        .to options["format"]
    end
  end

  describe ".load" do

    subject { try_in_sandbox { described_class.load } }

    context "when rubocop.yml is absent" do

      include_context "without rubocop.yml"

      it_behaves_like "environments loader"
    end

    context "when rubocop.yml is present" do

      include_context "with rubocop.yml"

      it_behaves_like "environments loader"
    end
  end
end
