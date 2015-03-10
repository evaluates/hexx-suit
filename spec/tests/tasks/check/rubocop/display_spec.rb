# encoding: utf-8

describe "Rake::Task['check:rubocop:display']", :tasks do

  # The {#commands} variable is defined in the spec/support/config/tasks.rb
  # It collects the list of commands, that has been sent to system by
  # any instance of Hexx::RSpec::System utility.

  let(:task)   { Rake::Task["check:rubocop:display"] }

  shared_context "without rubocop.yml" do

    let(:options) { { "output" => "tmp/rubocop/index.html" } }
  end

  shared_context "with rubocop.yml" do

    let(:options) { { "output" => "custom/rubocop.html" } }

    before { prepare_settings options, "config/metrics/rubocop.yml" }
  end

  shared_examples "metric loader" do

    after { subject }

    it "[loads rubocop]" do
      expect(Hexx::Suit::Metrics::Rubocop).to receive :load
    end
  end

  shared_examples "results displayer" do

    it "displays rubocop results" do
      expect { subject }
        .to change { commands }
        .to ["launchy #{ options['output'] }"]
    end
  end

  describe ".invoke", :sandbox do

    subject { try_in_sandbox { task.invoke } }

    context "when .metrics.yml is absent" do

      include_context "without rubocop.yml"

      it_behaves_like "metric loader"
      it_behaves_like "results displayer"
    end

    context "when .metrics.yml is present" do

      include_context "with rubocop.yml"

      it_behaves_like "metric loader"
      it_behaves_like "results displayer"
    end
  end
end
