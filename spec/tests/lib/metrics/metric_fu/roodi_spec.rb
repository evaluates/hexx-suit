# encoding: utf-8
require "spec_helper"
require "metric_fu"

describe Hexx::Suit::Metrics::MetricFu::Roodi, :sandbox do

  let(:config) do
    ::MetricFu::Configuration.configure_metric(:roodi) do |metric|
      metric.instance_eval { @configured_run_options || {} }
    end
  end

  describe ".load" do

    subject { try_in_sandbox { described_class.load } }

    it "configures the metric from roodi.yml" do
      subject
      expect(config[:roodi_config]).to eq "config/metrics/roodi.yml"
    end
  end
end
