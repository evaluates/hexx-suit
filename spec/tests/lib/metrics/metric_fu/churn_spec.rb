# encoding: utf-8
require "spec_helper"
require "metric_fu"

describe Hexx::Suit::Metrics::MetricFu::Churn, :sandbox, :capture do

  let(:config) do
    ::MetricFu::Configuration.configure_metric(:churn) do |metric|
      metric.instance_eval { @configured_run_options || {} }
    end
  end

  let(:settings) do
    {
      "ignore_files"        => %w(spec),
      "minimum_churn_count" => "1",
      "start_date"          => "6 months ago"
    }
  end

  describe ".load" do

    before  { prepare_settings settings, "config/metrics/churn.yml" }
    subject { try_in_sandbox { described_class.load } }

    it "configures the metric from churn.yml" do
      subject
      settings.each { |key, value| expect(config[key.to_sym]).to eq value }
    end
  end
end
