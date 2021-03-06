# encoding: utf-8
require "spec_helper"
require "metric_fu"

describe Hexx::Suit::Metrics::MetricFu::Reek, :sandbox, :capture do

  let(:config) do
    ::MetricFu::Configuration.configure_metric(:reek) do |metric|
      metric.instance_eval { @configured_run_options || {} }
    end
  end

  describe ".load" do

    subject { try_in_sandbox { described_class.load } }

    it "configures the metric from reek.yml" do
      subject
      expect(config[:config_file_pattern]).to eq "config/metrics/reek.yml"
    end
  end
end
