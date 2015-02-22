# encoding: utf-8

describe "hexx-suit install", :sandbox do

  describe "install" do

    before { try_in_sandbox { `hexx-suit install` } }

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
      ).each { |file| expect(file).to be_present_in_sandbox }
    end
  end
end
