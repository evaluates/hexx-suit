# encoding: utf-8

describe "Rake::Task[:test]", :tasks do

  # The {#commands} variable is defined in the spec/support/config/tasks.rb
  # It collects the list of commands, that has been sent to system by
  # any instance of Hexx::Suit::Utils::System utility.

  let(:task) { Rake::Task[:test] }

  describe ".invoke", :sandbox do

    subject { try_in_sandbox { task.invoke } }

    it "runs tests" do
      expect { subject }.to change { commands }.to [
        "bundle exec rspec spec"
      ]
    end
  end
end
