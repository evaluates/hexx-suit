# encoding: utf-8
require "spec_helper"
require "metric_fu"

describe Hexx::Suit::Metrics::MetricFu::Flay, :sandbox do

  let(:config) do
    ::MetricFu::Configuration.configure_metric(:flay) do |metric|
      metric.instance_eval { @configured_run_options || {} }
    end
  end

  let(:settings) do
    { "minimum_score" => "10" }
  end

  describe ".load" do

    before  { prepare_settings settings, "config/metrics/flay.yml" }
    subject { try_in_sandbox { described_class.load } }

    it "configures the metric from flay.yml" do
      subject
      settings.each { |key, value| expect(config[key.to_sym]).to eq value }
    end
  end
end
