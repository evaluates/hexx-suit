# encoding: utf-8

describe "Rake::Task['check:coverage']", :tasks do

  # The {#task_invoked?} helper is defined in the spec/support/config/tasks.rb
  # It checks if a task has been invoked.

  let(:task) { Rake::Task["check:coverage"] }

  describe ".invoke", :sandbox do

    subject { try_in_sandbox { task.invoke } }

    it "invokes check:coverage:run" do
      expect { subject }
        .to change { task_invoked? "check:coverage:run" }
        .to(true)
    end

    it "invokes check:coverage:display" do
      expect { subject }
        .to change { task_invoked? "check:coverage:display" }
        .to(true)
    end
  end
end
