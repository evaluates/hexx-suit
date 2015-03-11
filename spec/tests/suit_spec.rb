# encoding: utf-8

describe Hexx::Suit do

  let(:coverage_settings) { Hexx::RSpec::Metrics::SimpleCov }
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
        check:display
        check:fu
        check:fu:display
        check:fu:run
        check:inch
        check:rubocop
        check:rubocop:display
        check:rubocop:run
        check:run
        check:yardstick
        check:yardstick:display
        check:yardstick:run
        debug
        test
        test:coverage
        test:coverage:display
        test:coverage:run
      ))
    end

  end # describe .install_tasks

  describe ".load_metrics_for" do

    let(:scope) { double }
    after { described_class.load_metrics_for scope }

    it "runs Hexx::Suit.load_metrics_for" do
      expect(Hexx::RSpec).to receive(:load_metrics_for).with(scope)
    end

  end # describe .load_metrics_for

end
