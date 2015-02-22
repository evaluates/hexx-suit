# encoding: utf-8

describe Hexx::Suit do

  let(:coverage_settings) { described_class::Metrics::SimpleCov }
  let(:pippi_settings)    { described_class::Metrics::Pippi     }
  let(:rake_tasks)        { Rake::Task.tasks.map(&:name)        }

  describe ".install_tasks" do

    before { described_class.install_tasks }

    it "installs Gem tasks" do
      expect(rake_tasks).to include("build", "install", "release")
    end

    it "installs RSpec tasks" do
      expect(rake_tasks).to include("spec")
    end

    it "installs described_class tasks" do
      expect(rake_tasks).to include(*%w(
        check
        check:coverage
        check:coverage:display
        check:coverage:run
        check:display
        check:fu
        check:fu:display
        check:fu:run
        check:inch
        check:pippi
        check:pippi:display
        check:pippi:run
        check:rubocop
        check:rubocop:display
        check:rubocop:run
        check:run
        check:yardstick
        check:yardstick:display
        check:yardstick:run
        debug
        test
      ))
    end
  end

  describe ".load_metrics_for" do

    subject { described_class.load_metrics_for(double) }

    it "returns self" do
      expect(subject).to eq described_class
    end

    context "when ENV[USE_SIMPLECOV] is set" do

      before  { ENV["USE_SIMPLECOV"] = "true" }

      it "initializes and runs a coverage settings" do
        expect(coverage_settings).to receive(:run)
        subject
      end
    end

    context "when ENV[USE_PIPPI] is set" do

      before  { ENV["USE_PIPPI"] = "true" }

      it "initializes and runs a pippi settings" do
        expect(pippi_settings).to receive(:run)
        subject
      end
    end

    context "when ENV[USE_SIMPLECOV] isn't set" do

      before { ENV["USE_SIMPLECOV"] = nil }

      it "doesn't run settings" do
        expect(coverage_settings).not_to receive(:run)
        subject
      end
    end

    context "when ENV[USE_PIPPI] isn't set" do

      before { ENV["USE_PIPPI"] = nil }

      it "doesn't run settings" do
        expect(pippi_settings).not_to receive(:run)
        subject
      end
    end
  end
end
