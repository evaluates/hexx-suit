# encoding: utf-8
require "spec_helper"
require "metric_fu"

describe Hexx::Suit::Metrics::MetricFu::Cane, :sandbox do

  let(:config) do
    ::MetricFu::Configuration.configure_metric(:cane) do |metric|
      metric.instance_eval { @configured_run_options || {} }
    end
  end

  let(:settings) do
    {
      "abc_max"      => "10",
      "line_length"  => "80",
      "no_doc"       => "y",
      "no_readme"    => "y"
    }
  end

  describe ".load" do

    before  { prepare_settings settings, "config/metrics/cane.yml" }
    subject { try_in_sandbox { described_class.load } }

    it "configures the metric from cane.yml" do
      subject
      settings.each { |key, value| expect(config[key.to_sym]).to eq value }
    end
  end
end
