# encoding: utf-8
require "spec_helper"
require "metric_fu"

describe Hexx::Suit::Metrics::MetricFu::Saikuro, :sandbox, :capture do

  let(:config) do
    ::MetricFu::Configuration.configure_metric(:saikuro) do |metric|
      metric.instance_eval { @configured_run_options || {} }
    end
  end

  let(:settings) do
    {
      "warn_cyclo"  => "3",
      "error_cyclo" => "5"
    }
  end

  describe ".load" do

    before  { prepare_settings settings, "config/metrics/saikuro.yml" }
    subject { try_in_sandbox { described_class.load } }

    it "configures the metric from saikuro.yml" do
      subject
      settings.each { |key, value| expect(config[key.to_sym]).to eq value }
    end
  end
end
