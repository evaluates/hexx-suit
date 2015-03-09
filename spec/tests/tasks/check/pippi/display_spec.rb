# encoding: utf-8

describe "Rake::Task['check:pippi:display']", :tasks do

  # The {#commands} variable is defined in the spec/support/config/tasks.rb
  # It collects the list of commands, that has been sent to system by
  # any instance of Hexx::Suit::Utils::System utility.

  let(:metric) { Hexx::Suit::Metrics::Pippi }
  let(:task)   { Rake::Task["check:pippi:display"] }

  describe ".invoke", :sandbox do

    subject { try_in_sandbox { task.invoke } }

    context "when '.metrics.yml' is absent" do

      it "loads the metric" do
        expect(metric).to receive(:load)
        subject
      end

      it "displays the output" do
        expect { subject }
          .to change { commands.include? "cat tmp/pippi/output.log" }
          .to true
      end
    end

    context "when '.metrics.yml' is present" do

      let(:options) { { "output" => "custom/pippi.log" } }
      before { prepare_settings options, "config/metrics/pippi.yml" }

      it "loads the metric" do
        expect(metric).to receive(:load)
        subject
      end

      it "uses the custom output" do
        expect { subject }
          .to change { commands.include? "cat #{ options['output'] }" }
          .to true
      end
    end
  end

end if USE_PIPPI_METRIC
