# encoding: utf-8

describe "Rake::Task['check:yardstick']", :tasks do

  # The {#task_invoked?} helper is defined in the spec/support/config/tasks.rb
  # It checks if a task has been invoked.

  let(:task) { Rake::Task["check:yardstick"] }

  describe ".invoke", :sandbox, :capture do

    subject { try_in_sandbox { task.invoke } }

    it "invokes check:yardstick:run" do
      expect { subject }
        .to change { task_invoked? "check:yardstick:run" }
        .to(true)
    end

    it "invokes check:yardstick:display" do
      expect { subject }
        .to change { task_invoked? "check:yardstick:display" }
        .to(true)
    end
  end
end
