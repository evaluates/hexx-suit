# encoding: utf-8
require "spec_helper"
require "metric_fu"

describe Hexx::Suit::Metrics::MetricFu, :sandbox, :capture do

  shared_context "without metric_fu.yml" do

    let(:options) do
      {
        "folders" => %(lib app),
        "format"  => "html",
        "metrics" => %w(cane churn flay flog reek roodi saikuro),
        "output"  => "tmp/metric_fu",
        "verbose" => false
      }
    end
  end

  shared_context "with metric_fu.yml" do

    let(:options) do
      {
        "folders" => %(custom),
        "format"  => "yaml",
        "metrics" => %w(hotspots stats),
        "output"  => "custom",
        "verbose" => true
      }
    end

    before { prepare_settings options, "config/metrics/metric_fu.yml" }
  end

  shared_examples "environment setter" do

    before { ENV["METRIC_FU_OUTPUT"] = nil }

    it "[sets METRIC_FU_OUTPUT]" do
      expect { subject }
        .to change { ENV["METRIC_FU_OUTPUT"] }
        .to options["output"]
    end
  end

  shared_examples "verbose setter" do

    before { subject }

    it "[sets verbose from options]" do
      ::MetricFu::Configuration.run do |config|
        expect(config.verbose).to eq options["verbose"]
      end
    end
  end

  shared_examples "metrics selector" do

    def enabled?(name)
      ::MetricFu::Configuration.configure_metric(name.to_sym) do |metric|
        metric.instance_eval { @enabled }
      end
    end

    let(:metrics) do
      %w(
        cane churn flay flog hotspots rails_best_practices rcov reek roodi
        saikuro stats
      )
    end
    let(:allowed_metrics)  { options["metrics"]         }
    let(:disabled_metrics) { metrics - allowed_metrics  }

    before { subject }

    it "[enables allowed metrics]" do
      allowed_metrics.each { |name| expect(enabled? name).to be_truthy }
    end

    it "[disables other metrics]" do
      disabled_metrics.each { |name| expect(enabled? name).to be_falsey }
    end
  end

  shared_examples "folders setter" do

    def run_options(name)
      ::MetricFu::Configuration.configure_metric(name.to_sym) do |metric|
        metric.instance_eval { @configured_run_options || {} }
      end
    end

    let(:folders) { options["folders"] }

    before { subject }

    it "[sets cane folders]" do
      expect(run_options(:cane)[:dirs_to_cane]).to eq folders
    end

    it "[sets churn folders]" do
      expect(run_options(:churn)[:dirs_to_churn]).to eq folders
    end

    it "[sets flay folders]" do
      expect(run_options(:flay)[:dirs_to_flay]).to eq folders
    end

    it "[sets flog folders]" do
      expect(run_options(:flog)[:dirs_to_flog]).to eq folders
    end

    it "[sets reek folders]" do
      expect(run_options(:reek)[:dirs_to_reek]).to eq folders
    end

    it "[sets roodi folders]" do
      expect(run_options(:roodi)[:dirs_to_roodi]).to eq folders
    end

    it "[sets saikuro folders]" do
      expect(run_options(:saikuro)[:input_directory]).to eq folders
    end
  end

  shared_examples "metrics loader" do

    after { subject }

    it "[loads cane]" do
      expect(described_class::Cane).to receive :load
    end

    it "[loads churn]" do
      expect(described_class::Churn).to receive :load
    end

    it "[loads flay]" do
      expect(described_class::Flay).to receive :load
    end

    it "[loads reek]" do
      expect(described_class::Reek).to receive :load
    end

    it "[loads roodi]" do
      expect(described_class::Roodi).to receive :load
    end

    it "[loads saikuro]" do
      expect(described_class::Saikuro).to receive :load
    end
  end

  describe ".load" do

    subject { try_in_sandbox { described_class.load } }

    context "when metric_fu.yml is absent" do

      include_context "without metric_fu.yml"

      it_behaves_like "environment setter"
      it_behaves_like "verbose setter"
      it_behaves_like "metrics selector"
      it_behaves_like "folders setter"
      it_behaves_like "metrics loader"
    end

    context "when metric_fu.yml is present" do

      include_context "with metric_fu.yml"

      it_behaves_like "environment setter"
      it_behaves_like "verbose setter"
      it_behaves_like "metrics selector"
      it_behaves_like "folders setter"
      it_behaves_like "metrics loader"
    end
  end
end
