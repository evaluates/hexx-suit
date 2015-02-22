# encoding: utf-8

describe Hexx::Suit::Install, :sandbox do

  describe ".start" do

    before { try_in_sandbox { described_class.start } }

    it "creates necessary files" do
      %w(
        .rspec
        .yardopts
        Guardfile
        Rakefile
        config/metrics/cane.yml
        config/metrics/churn.yml
        config/metrics/flay.yml
        config/metrics/metric_fu.yml
        config/metrics/pippi.yml
        config/metrics/reek.yml
        config/metrics/roodi.yml
        config/metrics/rubocop.yml
        config/metrics/saikuro.yml
        config/metrics/simplecov.yml
        config/metrics/yardstick.yml
        config/metrics/STYLEGUIDE
      ).each { |file| expect(file).to be_present_in_sandbox }
    end

    it "adds Hexx::Suit tasks loader to Rakefile" do
      expect(read_in_sandbox "Rakefile").to include "Hexx::Suit.install_tasks"
    end
  end
end