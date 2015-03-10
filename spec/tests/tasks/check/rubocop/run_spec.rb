# encoding: utf-8

describe "Rake::Task['check:rubocop:run']", :tasks do

  # The {#commands} variable is defined in the spec/support/config/tasks.rb
  # It collects the list of commands, that has been sent to system by
  # any instance of Hexx::RSpec::System utility.

  let(:task)   { Rake::Task["check:rubocop:run"] }

  shared_context "without rubocop.yml" do

    let(:options) do
      {
        "output"  => "tmp/rubocop/index.html",
        "format"  => "html"
      }
    end
  end

  shared_context "with rubocop.yml" do

    let(:options) do
      {
        "output"  => "custom/rubocop.html",
        "format"  => "yml"
      }
    end

    before { prepare_settings options, "config/metrics/rubocop.yml" }
  end

  shared_examples "metric loader" do

    after { subject }

    it "[loads rubocop]" do
      expect(Hexx::Suit::Metrics::Rubocop).to receive :load
    end
  end

  shared_examples "metric runner" do

    let(:command) do
      %W(
        rubocop
        -f #{ options['format'] }
        -o #{ options['output'] }
        -c config/metrics/rubocop.yml
      ).join(" ")
    end

    it "[runs rubocop]" do
      expect { subject }.to change { commands }.to [command]
    end
  end

  describe ".invoke", :sandbox do

    subject { try_in_sandbox { task.invoke } }

    context "when .metrics.yml is absent" do

      include_context "without rubocop.yml"

      it_behaves_like "metric loader"
      it_behaves_like "metric runner"
    end

    context "when .metrics.yml is present" do

      include_context "with rubocop.yml"

      it_behaves_like "metric loader"
      it_behaves_like "metric runner"
    end
  end
end
